#include <QFontDatabase>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>
#include <QTranslator>

#include "sidebarmodel.h"
#include "answerareamodel.h"
#include "questionlistmodel.h"

int main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qmlRegisterType<ScoreboardModel>("ScoreboardModel", 1, 0, "ScoreboardModel");
    QGuiApplication app(argc, argv);

    // Currently only Polish translation is available.
    // Uncomment the lines below to translate the app to Polish

//    QTranslator translator;
//    const QString polishTranslation = "Weseliada_pl_PL";
//    translator.load(polishTranslation);
//    app.installTranslator(&translator);

    auto screens = app.screens();
    for (auto* screen : screens) {
        qDebug() << QString("Available screen %1 by %2 of size: ").arg(screen->serialNumber()).arg(screen->model()) << screen->size();
    }
    QQmlApplicationEngine engine;
    QQmlContext *root_context = engine.rootContext();

    AnswerAreaModel answerAreaModel(10, 24);
    root_context->setContextProperty("answerAreaModelCpp", &answerAreaModel);

    SidebarModel leftSidebarModel;
    root_context->setContextProperty("leftSidebarModelCpp", &leftSidebarModel);

    SidebarModel rightSidebarModel;
    root_context->setContextProperty("rightSidebarModelCpp", &rightSidebarModel);

    QuestionListModel questionListModel;
    root_context->setContextProperty("questionListModelCpp", &questionListModel);

    root_context->setContextProperty("leftTeamScoreModelCpp", answerAreaModel.getTeamModel(Team::Left));
    root_context->setContextProperty("rightTeamScoreModelCpp", answerAreaModel.getTeamModel(Team::Right));

    const QUrl mainUrl(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app, [mainUrl](QObject* obj, const QUrl& objUrl) {
            if (!obj && mainUrl == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(mainUrl);

    questionListModel.readQuestionsFromFile(QStringLiteral(":/data/questions.json"));
    qDebug() << "Loaded questions count: " << questionListModel.rowCount();

    QFontDatabase::addApplicationFont(":/fonts/ecran_monochrome.ttf");
    QFontDatabase::addApplicationFont(":/fonts/led_calculator.ttf");

    return app.exec();
}

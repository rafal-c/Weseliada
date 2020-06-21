#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "sidebarmodel.h"
#include "answerareamodel.h"
#include "questionlistmodel.h"

int main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qmlRegisterType<ScoreboardModel>("ScoreboardModel", 1, 0, "ScoreboardModel");
    QGuiApplication app(argc, argv);

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

    return app.exec();
}

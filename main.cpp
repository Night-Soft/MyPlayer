#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QApplication>
#include <QDesktopWidget>
#include <QQmlComponent>

#include <myplayer.h>
#include <listviewc.h>
#include <ellipse.h>

int main(int argc, char *argv[])
{
    qmlRegisterType<Ellipse>("com.myinc.Ellipse", 1, 0, "Ellipse");


//    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

//    QGuiApplication app(argc, argv);
//    app.setWindowIcon(QIcon(":/resources/images/MyPlayer.png"));

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    if (engine.rootObjects().isEmpty())
//        return -1;

//    return app.exec();

     QApplication a(argc, argv);
//    QTranslator translator;
//    //translator.load(":/languages/ru.qm");
//    translator.load(":/languages/" + QLocale::system().name());
//    a.installTranslator(&translator);
//    MainWindow *w = new MainWindow();
//    screenrect *rect = new screenrect();
//    rect->windowCenter(w);
    // qmlRegisterType<ListViewC>("com.myinc.ListviewC", 1, 0, "ListViewC");

     MyPlayer *w = new MyPlayer();
     w->show();
/*     QQmlApplicationEngine eng;

     QQmlComponent comp(&eng, QUrl("qrc:/main.qml"));
     QObject * pobj = comp.create()*/;

    return a.exec();
}

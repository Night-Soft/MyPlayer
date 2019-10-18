#include <QVBoxLayout>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QtQuick>
#include <QList>
#include <QFileDialog>
#include <QMediaMetaData>
#include <QJSEngine>
#include "myplayer.h"
#include "ui_myplayer.h"

MyPlayer::MyPlayer(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::MyPlayer)
{

    ui->setupUi(this);
    //this->setWindowFlags(Qt::FramelessWindowHint);

    widget = ui->quickWidget;
    buttonClose = ui->pushButton;
    list = ui->listWidget;
    playlistModel = new QStandardItemModel(this);
    settingsSave = new QSettings("settings.conf", QSettings::NativeFormat);

    widget->setSource(QUrl("qrc:/main.qml"));
    QObject *obj = widget->rootObject();
    pcon = widget->rootContext();
    QList<QString> lis;
    lis.append("playButton1");
    lis.append("stopButton");
    QObject *playControl =  obj->findChild<QObject*>("playButton1");
    QObject *stopControl =  obj->findChild<QObject*>("stopButton");
    QObject *addFil = obj->findChild<QObject*>("addFiless");
    sliderVolume = obj->findChild<QObject*>("sliderVolume");
    fileNameSon = obj->findChild<QObject*>("nameFileSong");
    addFilesList = obj->findChild<QObject*>("listmodell");
    nextSong = obj->findChild<QObject*>("nextSong");
    previousSong = obj->findChild<QObject*>("previousSong");
    nameSong = obj->findChild<QObject*>("nameSong");
    testObject = obj->findChild<QObject*>("testObject");
    checkBoxPlay = obj->findChild<QObject*>("chBxPlay");
    //QList<QObject *> listObj = obj->findChildren<QObject*>("chBxPlay");

    if(previousSong){
        connect(previousSong, SIGNAL(previousSongSignal()), this, SLOT(onPreviousSongClicked()));
    }
    if(nextSong){
        connect(nextSong, SIGNAL(nextSongSignal()),this, SLOT(onNextSongClicked()));
    }
    if (sliderVolume){
        connect(sliderVolume, SIGNAL(sliderVolumeSignal()), this, SLOT(onSliderVolumeChanged()));
    }
    if(playControl){
        connect(playControl, SIGNAL(playSignal()), this, SLOT(onPlayClicked()));
    }
    if(stopControl){
        connect(stopControl, SIGNAL(stopSignal()), this, SLOT(onStopClicked()));
    }
    if (addFil){
        connect(addFil, SIGNAL(addFilesSignal()), this, SLOT(onAddFilesClicked()));
    }
    if(checkBoxPlay){
        connect(checkBoxPlay, SIGNAL(chBxSignal()), this, SLOT(saveSettings()));
    }


//    if(addFilesList){
//        connect(addFilesList, SIGNAL(listFilesSignal()), this, SLOT(addListFiles()));
//    }


    player = new QMediaPlayer(this);
    playlist = new QMediaPlaylist(player);
    player->setPlaylist(playlist);
    QStringList stringList;

    playlist->addMedia(QUrl::fromLocalFile("/media/yurii/F/MUSIC/Chris de Burgh - Missing you.mp3")); //in linux work
    playlist->addMedia(QUrl("http://air.radioulitka.ru:8000/ulitka_96"));// work it
    playlist->addMedia(QUrl("http://138.201.33.223/club"));// work it
    //laylist->mediaObject()

    //        foreach (playlist, playlist->mediaCount()) {
    //            stringList.append(playlist->)
    //        }
    list->addItems(stringList);
    playlist->setCurrentIndex(0);
    player->setVolume(sliderVolume->property("value").toReal());
    // player->setMedia(QMediaContent::canonicalRequest());
    buttonClose->setText("play");
    //nameSong->setProperty("text", player->metaData(QMediaMetaData::Title));
    sliderVolume->setProperty("value", 100);
    readSettings();
   // saveSettings();
//    int count = 1;
//    int sT = 0;
//    for(int i = 100; i > 0; i-- ){
//        sT = count * 2;
//        //qDebug() << "i = " + i,  " sT = " + sT;
//    }



}

MyPlayer::~MyPlayer()
{
    delete ui;
}
void MyPlayer::saveSettings(){
    buttonClose->setText("sign");
    qDebug() << "signal work";
    settingsSave->setValue("settings/checkBoxPlay", checkBoxPlay->property("checkedState"));
    qDebug() << "setting add";

}

void MyPlayer::readSettings(){
    checkBoxPlay->setProperty("checkedState", settingsSave->value("settings/checkBoxPlay", 2).toInt());
    qDebug() << settingsSave->value("settings/checkBoxPlay", 2).toInt() << "property add" ;
    if(settingsSave->value("settings/checkBoxPlay").toInt() == 2){
        player->play();
    }
    QString retVal;
    Q_INVOKABLE  int append = addFilesList->metaObject()->indexOfMethod("append(jsobject)");
    QMetaMethod method = addFilesList->metaObject()->method(append);
    method.invoke(addFilesList, Q_ARG(QVariant, "name"), Q_ARG(QVariant, "34"));
    appendd();
//    QMetaObject::invokeMethod(addFilesList,
//                "append",
//                QGenericReturnArgument(),
//    //            Q_ARG(Thing::DataEvent, event));
//                Q_ARG(QVariant, "name"), Q_ARG(QVariant, "34"));
}
void MyPlayer::appendd(){
    for (int i = 0; i < addFilesList->metaObject()->methodCount(); ++i) {
               QMetaMethod method = addFilesList->metaObject()->method(i);
               //qDebug() << method.methodSignature();
            }
}
void MyPlayer::addListFiles(){
}
void MyPlayer::addNameFile(QString *nameFile){
}
bool play = true;
void MyPlayer::onPreviousSongClicked() {
    //playlist->setCurrentIndex(0);
    nameSong->setProperty("text", player->metaData(QMediaMetaData::Title).toString());
    playlist->previous();
    long long int l = player->duration();
    buttonClose->setText(QString::number(l));
    nameSong->setProperty("text", player->metaData(QMediaMetaData::Title).toString());

}
void MyPlayer::onNextSongClicked() {
    //playlist->setCurrentIndex(1);
    nameSong->setProperty("text", player->metaData(QMediaMetaData::Title).toString());
    playlist->next();
    player->setPosition(213);
    long l = player->duration();
    buttonClose->setText(QString::number(l));
    nameSong->setProperty("text", player->metaData(QMediaMetaData::Title).toString());

}
void MyPlayer::onSliderVolumeChanged(){
    sliderVolume->property("value");
    player->setVolume(sliderVolume->property("value").toReal());
    buttonClose->setText(QString::number(sliderVolume->property("value").toReal()));
}
void MyPlayer::onPlayClicked(){
//buttonClose->setText("ok");
    if(play== true){
        nameSong->setProperty("text", player->metaData(QMediaMetaData::Title).toString());
        player->play();
        buttonClose->setText("pause");
        buttonClose->setText(player->metaData(QMediaMetaData::Title).toString());
        nameSong->setProperty("text", player->metaData(QMediaMetaData::Title).toString());

        play = false;
    } else {
        player->stop();
        buttonClose->setText("play");
        play = true;
    }
}
void MyPlayer::on_pushButton_clicked()
{
        int count = 1;
        int sum = 0;
        for(int i = 0; i < 100; i++ ){
            sum = count * 2;
            count = sum;
            qDebug() << "i = " + QString::number(i) + " sum = " + QString::number(sum);
        }
//    QObject *someObject = testObject;
//    someObject->setProperty("text", "somesome");
//    engine.globalObject().setProperty("testObject", objectValue);
    //testObject->setProperty("text", "somesome");
    QJSEngine engine;
    list->setObjectName("list");
    buttonClose->setObjectName("button");
    QFile file(":/myfunctions.js");
    if(file.open(QFile::ReadOnly)){
       QJSValue objectValue = engine.newQObject(buttonClose);
       engine.globalObject().setProperty("button", objectValue);
       engine.evaluate(QLatin1String(file.readAll()));
    }
      nameSong->setProperty("text", player->metaData(QMediaMetaData::Title).toString());
    // С помощью диалога выбора файлов делаем множественный выбор mp3 файлов
      QStringList files = QFileDialog::getOpenFileNames(this,
                                                        tr("Open files"),
                                                        QString(),
                                                        tr("Audio list (*.m3u)"));

      // Далее устанавливаем данные по именам и пути к файлам
      // в плейлист и таблицу отображающую плейлист
      foreach (QString filePath, files) {
          QList<QStandardItem *> items;
          items.append(new QStandardItem(QDir(filePath).dirName()));
          items.append(new QStandardItem(filePath));
          playlistModel->appendRow(items);
          playlist->addMedia(QUrl(filePath));
      }



}
void MyPlayer::onAddFilesClicked(){
    buttonClose->setText("dsf");
    QFileDialog fileDialog;

    QString filesTXT = fileDialog.getOpenFileName(this,
                                                      tr("Open files"),
                                                      QString(QStandardPaths::standardLocations(QStandardPaths::HomeLocation).at(0)),
                                                      tr("Audio list (*.m3u);;Audio files (*.mp3)"));

    // Далее устанавливаем данные по именам и пути к файлам
    // в плейлист и таблицу отображающую плейлист
    QStringList stringList;
    QFile textFile(filesTXT);
    QFile textWrite ("tex.txt");
    QString filename="Data.txt";
    QFile file( filename );
    QString filterM3u = tr("Audio files (*.mp3)");
    int i = 0;
    QString str;

    if(fileDialog.selectedNameFilter() == filterM3u){
        foreach (QString filePath, filesTXT) {
            QList<QStandardItem *> items;
            items.append(new QStandardItem(QDir(filePath).dirName()));
            items.append(new QStandardItem(filePath));
            playlistModel->appendRow(items);
            playlist->addMedia(QUrl(filePath));
            i++;
        }
        buttonClose->setText(QString::number(i));

    } else {
        if (textFile.open(QIODevice::ReadOnly)){
        QTextStream textStream(&textFile);
        QTextStream textStreamm(&textFile);

//        int ii = 0;
//        while (!textStream.atEnd()) {
//            textStream.readLine();
//            ii++;
//        }
//        textStream.reset();
        if ( file.open(QIODevice::ReadWrite) ){
            QTextStream stream( &file );
//            for(; ii>=0; ii--){
//                stream << textStreamm.readLine(i) << endl; // write in file
//                playlist->addMedia(QUrl(textStreamm.readLine(i)));
//                stringList.append(textStreamm.readLine(i));
//                i++;
//            }
            while (!textStream.atEnd()){
                //stream << textStreamm.readLine() << endl;
                //playlist->addMedia(QUrl(textStreamm.readLine()));
                stringList.append(textStream.readLine());
                playlist->addMedia(QUrl(stringList.last()));
                i++;
                //fileNameSon->setProperty("nameFileSong", QVariant(textStream.readLine()));
            }
            buttonClose->setText(QString::number(i));
            list->addItems(stringList);
        }
        }

    }



//    foreach (QString filePath, filesTXT) {
//        QFile textFile(filesTXT);
//        QTextStream textStream(&textFile);
//        //QList<QStandardItem *> items;
//        //items.append(new QStandardItem(QDir(filePath).dirName()));
//        //items.append(new QStandardItem(filePath));
//        playlist->addMedia(QUrl(textStream.readLine()));
//    }
}

void MyPlayer::onStopClicked(){
    player->stop();
    play = true;
}

void MyPlayer::on_listWidget_itemDoubleClicked(QListWidgetItem *item)
{
 nameSong->setProperty("text", player->metaData(QMediaMetaData::Title).toString());

 playlist->setCurrentIndex(list->currentRow());
 player->stop();
 player->play();
 nameSong->setProperty("text", player->metaData(QMediaMetaData::Title).toString());

}

#ifndef MYPLAYER_H
#define MYPLAYER_H

#include <QWidget>
#include <QQuickWidget>
#include <QPushButton>
#include <QtCore>
#include <QStandardItemModel>
#include <QListWidget>
#include <QJSValue>
#include <QJSEngine>
#include <QSettings>

#include <QMediaPlayer>
#include <QMediaPlaylist>


namespace Ui {
class MyPlayer;
}

class MyPlayer : public QWidget
{
    Q_OBJECT

public:
    explicit MyPlayer(QWidget *parent = nullptr);
    ~MyPlayer();

private:
    Ui::MyPlayer *ui;

public:
    QQuickWidget * widget;
    QPushButton * buttonClose;
    QObject *fileNameSon;
    QObject *addFilesList;
    QObject *sliderVolume;
    QObject *nextSong;
    QObject *previousSong;
    QObject *nameSong;
    QObject *testObject;
    QObject *checkBoxPlay;
    QQmlContext *pcon;
    QListWidget *list;
    QJSValue scriptAdd;
    QJSEngine scriptJSEngine;
    QSettings * settingsSave;
    QStandardItemModel  *playlistModel;   // Модель данных плейлиста для отображения
    QMediaPlayer        *player;          // Проигрыватель треков
    QMediaPlaylist      *playlist;        // Плейлиста проигрывателя

signals:
    void sigAdd();
public slots:
    void on_pushButton_clicked();
    void onPlayClicked();
    void onStopClicked();
    void onAddFilesClicked();
    void addListFiles();
    void onSliderVolumeChanged();
    void onNextSongClicked();
    void onPreviousSongClicked();
    void addNameFile(QString *nameFile);
    void saveSettings();
    void readSettings();
    /*Q_INVOKABLE*/ void appendd();
    void on_listWidget_itemDoubleClicked(QListWidgetItem *item);
};

#endif // MYPLAYER_H

#ifndef LISTVIEWC_H
#define LISTVIEWC_H

#include <QQuickPaintedItem>
class ListViewC : public QQuickPaintedItem
{
    Q_OBJECT
private:
public:
    //QList<int> mList;
    ListViewC(QQuickItem *pgi =nullptr);

    //QList<QString> *list;
    //int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    //QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    //Q_PROPERTY(type name READ name WRITE setName NOTIFY nameChanged)
signals:

public slots:
    void append(QString * string);
};

#endif // LISTVIEWC_H

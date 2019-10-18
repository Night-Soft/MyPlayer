#ifndef ELLIPSE_H
#define ELLIPSE_H
#include <QQuickPaintedItem>
class QPainter;



class Ellipse : public QQuickPaintedItem {
Q_OBJECT
    private:
    Q_PROPERTY(QColor color WRITE setColorValue
               READ colorValue)
    QColor m_color;
//    Q_PROPERTY(QPen penn WRITE setPenValue
//               READ penValue)
//    QPen m_pen;
public:
    Ellipse(QQuickItem * pgi = 0);
    void paint(QPainter* ppainter);

    QColor colorValue ()const;
    void setColorValue(const QColor);

//    QPen penValue ()const;
//    void setPenValue(const QPen);
};

#endif // ELLIPSE_H

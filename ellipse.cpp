#include "ellipse.h"
#include <QPainter>


Ellipse::Ellipse(QQuickItem * pgi) : QQuickPaintedItem(pgi)
  , m_color(Qt::black)
//    m_pen(Qt::PenStyle::DotLine)
{
}
void Ellipse::paint(QPainter *ppainter){
    ppainter->setRenderHint(QPainter::Antialiasing, true);
    ppainter->setBrush(QBrush(colorValue()));
    ppainter->setPen(Qt::NoPen);
    ppainter->drawEllipse(boundingRect());
}
QColor Ellipse::colorValue() const {
    return m_color;
}

void Ellipse::setColorValue(const QColor col) {
    m_color = col;
}
//QPen Ellipse::penValue() const {
//    return m_pen;
//}
//void Ellipse::setPenValue(const QPen ennn) {
//    m_pen = ennn;
//}

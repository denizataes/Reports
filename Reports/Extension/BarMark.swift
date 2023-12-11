import Charts
import SwiftUI

// Bar mark için extension
extension BarMark {
    // Değerlerin birbirine çok yakın olup olmadığını kontrol eden fonksiyon
    func isCloseToOtherBars(_ currentValue: Double, _ otherValues: [Double], threshold: Double = 5.0) -> Bool {
        for value in otherValues {
            if abs(currentValue - value) < threshold {
                return true
            }
        }
        return false
    }
    
    // Bar mark için annotation ve çizgi ekleyen fonksiyon
    func annotatedBar(x: ChartAxisValue, y: ChartAxisValue, color: Color, label: String, value: Double, otherValues: [Double]) -> some View {
        BarMark(x: x, y: y)
            .foregroundStyle(color)
            .annotation(position: .overlay) {
                if isCloseToOtherBars(value, otherValues) {
                    VStack(spacing: 0) {
                        Text("\(label):")
                            .font(.system(size: 8))
                        Text(value.description)
                            .font(.system(size: 10))
                            .bold()
                    }
                    .foregroundStyle(.white)
                }
            }
            .overlay(
                // Çizgi eklemek için RoundedRectangle kullanabilirsiniz
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 1, height: 20)
                    .foregroundColor(.white)
                    .opacity(isCloseToOtherBars(value, otherValues) ? 1.0 : 0.0)
            )
    }
}

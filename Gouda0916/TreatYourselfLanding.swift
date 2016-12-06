


import UIKit
import CoreData

public class TreatYourselfLanding : NSObject {

    //// Drawing Methods

    let store = DataStore.sharedInstance
    
    public dynamic class func drawTreatYourselfLandingCircle(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 320, height: 568), resizing: ResizingBehavior = .aspectFit, progressDash: CGFloat = 8, velocityDash: CGFloat = 14, daysDash: CGFloat = 17) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 320, height: 568), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 320, y: resizedFrame.height / 568)


        //// Color Declarations
        let themeDarkGreen = UIColor(red: 0.000, green: 0.475, blue: 0.420, alpha: 1.000)
        let themeGold = UIColor(red: 1.000, green: 0.757, blue: 0.027, alpha: 1.000)
        let gradient3Color = UIColor(red: 0.163, green: 0.148, blue: 0.148, alpha: 1.000)
        var gradient3ColorHueComponent: CGFloat = 1
        var gradient3ColorSaturationComponent: CGFloat = 1
        var gradient3ColorBrightnessComponent: CGFloat = 1
        gradient3Color.getHue(&gradient3ColorHueComponent, saturation: &gradient3ColorSaturationComponent, brightness: &gradient3ColorBrightnessComponent, alpha: nil)

        let darkBkg = UIColor(hue: gradient3ColorHueComponent, saturation: gradient3ColorSaturationComponent, brightness: 0.5, alpha: gradient3Color.cgColor.alpha)
        let cremeColor = UIColor(red: 0.974, green: 0.968, blue: 0.821, alpha: 1.000)
        let color7 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Gradient Declarations
        let gradient = CGGradient(colorsSpace: nil, colors: [themeGold.cgColor, themeGold.blended(withFraction: 0.5, of: cremeColor).cgColor, cremeColor.cgColor] as CFArray, locations: [0.9, 1, 1])!
        let gradient2 = CGGradient(colorsSpace: nil, colors: [themeDarkGreen.cgColor, themeDarkGreen.blended(withFraction: 0.5, of: cremeColor).cgColor, cremeColor.cgColor] as CFArray, locations: [0.05, 1, 1])!
        let gradient3 = CGGradient(colorsSpace: nil, colors: [darkBkg.cgColor, darkBkg.blended(withFraction: 0.5, of: cremeColor).cgColor, cremeColor.cgColor] as CFArray, locations: [0, 1, 1])!

        //// ColorGroup
        //// ProgressOval Drawing
        context.saveGState()
        context.translateBy(x: 11, y: 132.7)
        context.scaleBy(x: 1.1, y: 1.1)

        let progressOvalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 270.91, height: 273))
        context.saveGState()
        progressOvalPath.addClip()
        context.drawLinearGradient(gradient, start: CGPoint(x: 135.45, y: 0), end: CGPoint(x: 135.45, y: 273), options: [])
        context.restoreGState()

        context.restoreGState()


        //// VelocityOval Drawing
        context.saveGState()
        context.translateBy(x: 52.68, y: 174.6)
        context.scaleBy(x: 0.8, y: 0.8)

        let velocityOvalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 270.91, height: 273))
        context.saveGState()
        velocityOvalPath.addClip()
        context.drawLinearGradient(gradient2, start: CGPoint(x: 135.45, y: 0), end: CGPoint(x: 135.45, y: 273), options: [])
        context.restoreGState()
        UIColor.white.setStroke()
        velocityOvalPath.lineWidth = 5
        velocityOvalPath.stroke()

        context.restoreGState()


        //// DaysOval Drawing
        context.saveGState()
        context.translateBy(x: 93.36, y: 215.5)
        context.scaleBy(x: 0.5, y: 0.5)

        let daysOvalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 270.91, height: 273))
        context.saveGState()
        daysOvalPath.addClip()
        context.drawLinearGradient(gradient3, start: CGPoint(x: 135.45, y: 0), end: CGPoint(x: 135.45, y: 273), options: [])
        context.restoreGState()
        UIColor.white.setStroke()
        daysOvalPath.lineWidth = 5
        daysOvalPath.stroke()

        context.restoreGState()




        //// MaskGroup
        context.saveGState()
        context.translateBy(x: 160, y: 284)
        context.rotate(by: -90.01 * CGFloat.pi/180)

        context.setBlendMode(.softLight)
        context.beginTransparencyLayer(auxiliaryInfo: nil)


        //// ProgressMask Drawing
        let progressMaskPath = UIBezierPath()
        progressMaskPath.move(to: CGPoint(x: 130, y: 0))
        progressMaskPath.addCurve(to: CGPoint(x: 0.5, y: 129), controlPoint1: CGPoint(x: 130, y: 71.24), controlPoint2: CGPoint(x: 72.02, y: 129))
        progressMaskPath.addCurve(to: CGPoint(x: -129, y: -0), controlPoint1: CGPoint(x: -71.02, y: 129), controlPoint2: CGPoint(x: -129, y: 71.24))
        progressMaskPath.addCurve(to: CGPoint(x: 0.5, y: -129), controlPoint1: CGPoint(x: -129, y: -71.24), controlPoint2: CGPoint(x: -71.02, y: -129))
        progressMaskPath.addCurve(to: CGPoint(x: 130, y: 0), controlPoint1: CGPoint(x: 72.02, y: -129), controlPoint2: CGPoint(x: 130, y: -71.24))
        progressMaskPath.close()
        color7.setStroke()
        progressMaskPath.lineWidth = 31
        context.saveGState()
        context.setLineDash(phase: 0, lengths: [progressDash, 812])
        progressMaskPath.stroke()
        context.restoreGState()
        

        //// VelocityMask Drawing
        let velocityMaskPath = UIBezierPath()
        velocityMaskPath.move(to: CGPoint(x: 89, y: 0))
        velocityMaskPath.addCurve(to: CGPoint(x: 1, y: 88), controlPoint1: CGPoint(x: 89, y: 48.6), controlPoint2: CGPoint(x: 49.6, y: 88))
        velocityMaskPath.addCurve(to: CGPoint(x: -87, y: 0), controlPoint1: CGPoint(x: -47.6, y: 88), controlPoint2: CGPoint(x: -87, y: 48.6))
        velocityMaskPath.addCurve(to: CGPoint(x: 1, y: -88), controlPoint1: CGPoint(x: -87, y: -48.6), controlPoint2: CGPoint(x: -47.6, y: -88))
        velocityMaskPath.addCurve(to: CGPoint(x: 89, y: 0), controlPoint1: CGPoint(x: 49.6, y: -88), controlPoint2: CGPoint(x: 89, y: -48.6))
        velocityMaskPath.close()
        color7.setStroke()
        velocityMaskPath.lineWidth = 30
        context.saveGState()
        context.setLineDash(phase: 0, lengths: [velocityDash, 552])
        velocityMaskPath.stroke()
        context.restoreGState()

        

        //// DayMask Drawing
        let dayMaskPath = UIBezierPath()
        dayMaskPath.move(to: CGPoint(x: 50, y: 0.5))
        dayMaskPath.addCurve(to: CGPoint(x: 35.94, y: 35.05), controlPoint1: CGPoint(x: 50, y: 13.94), controlPoint2: CGPoint(x: 44.64, y: 26.13))
        dayMaskPath.addCurve(to: CGPoint(x: 0.5, y: 50), controlPoint1: CGPoint(x: 26.95, y: 44.27), controlPoint2: CGPoint(x: 14.4, y: 50))
        dayMaskPath.addCurve(to: CGPoint(x: -49, y: 0.5), controlPoint1: CGPoint(x: -26.84, y: 50), controlPoint2: CGPoint(x: -49, y: 27.84))
        dayMaskPath.addCurve(to: CGPoint(x: 0.5, y: -49), controlPoint1: CGPoint(x: -49, y: -26.84), controlPoint2: CGPoint(x: -26.84, y: -49))
        dayMaskPath.addCurve(to: CGPoint(x: 50, y: 0.5), controlPoint1: CGPoint(x: 27.84, y: -49), controlPoint2: CGPoint(x: 50, y: -26.84))
        dayMaskPath.close()
        color7.setStroke()
        dayMaskPath.lineWidth = 30
        context.saveGState()
        context.setLineDash(phase: 0, lengths: [daysDash, 312])
        dayMaskPath.stroke()
        context.restoreGState()


        context.endTransparencyLayer()

        context.restoreGState()
        
        context.restoreGState()

    }

    public dynamic class func drawCanvas1(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 320, height: 568), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 320, height: 568), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 320, y: resizedFrame.height / 568)


        //// Color Declarations
        let themeDarkGreen = UIColor(red: 0.000, green: 0.475, blue: 0.420, alpha: 1.000)
        var themeDarkGreenHueComponent: CGFloat = 1
        var themeDarkGreenSaturationComponent: CGFloat = 1
        var themeDarkGreenBrightnessComponent: CGFloat = 1
        themeDarkGreen.getHue(&themeDarkGreenHueComponent, saturation: &themeDarkGreenSaturationComponent, brightness: &themeDarkGreenBrightnessComponent, alpha: nil)

        let darkGreenBkg = UIColor(hue: themeDarkGreenHueComponent, saturation: themeDarkGreenSaturationComponent, brightness: 0.8, alpha: themeDarkGreen.cgColor.alpha)
        let themeGold = UIColor(red: 1.000, green: 0.757, blue: 0.027, alpha: 1.000)
        var themeGoldRedComponent: CGFloat = 1
        var themeGoldGreenComponent: CGFloat = 1
        var themeGoldBlueComponent: CGFloat = 1
        themeGold.getRed(&themeGoldRedComponent, green: &themeGoldGreenComponent, blue: &themeGoldBlueComponent, alpha: nil)

        let goldBkg = UIColor(red: (themeGoldRedComponent * 0.3 + 0.7), green: (themeGoldGreenComponent * 0.3 + 0.7), blue: (themeGoldBlueComponent * 0.3 + 0.7), alpha: (themeGold.cgColor.alpha * 0.3 + 0.7))
        let gradient3Color = UIColor(red: 0.163, green: 0.148, blue: 0.148, alpha: 1.000)
        var gradient3ColorHueComponent: CGFloat = 1
        var gradient3ColorSaturationComponent: CGFloat = 1
        var gradient3ColorBrightnessComponent: CGFloat = 1
        gradient3Color.getHue(&gradient3ColorHueComponent, saturation: &gradient3ColorSaturationComponent, brightness: &gradient3ColorBrightnessComponent, alpha: nil)

        let darkBkg = UIColor(hue: gradient3ColorHueComponent, saturation: gradient3ColorSaturationComponent, brightness: 0.5, alpha: gradient3Color.cgColor.alpha)
        let cremeColor = UIColor(red: 0.974, green: 0.968, blue: 0.821, alpha: 1.000)

        //// Gradient Declarations
        let gradient3 = CGGradient(colorsSpace: nil, colors: [darkBkg.cgColor, darkBkg.blended(withFraction: 0.5, of: cremeColor).cgColor, cremeColor.cgColor] as CFArray, locations: [0, 1, 1])!

        //// ColorGroup
        context.saveGState()
        context.setBlendMode(.destinationOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)


        //// ProgressOval Drawing
        context.saveGState()
        context.translateBy(x: 11, y: 133.7)
        context.scaleBy(x: 1.1, y: 1.1)

        let progressOvalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 270, height: 271.18))
        goldBkg.setFill()
        progressOvalPath.fill()

        context.restoreGState()


        //// VelocityOval Drawing
        context.saveGState()
        context.translateBy(x: 52.54, y: 175.46)
        context.scaleBy(x: 0.8, y: 0.8)

        let velocityOvalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 270, height: 272.09))
        darkGreenBkg.setFill()
        velocityOvalPath.fill()
        UIColor.white.setStroke()
        velocityOvalPath.lineWidth = 5
        velocityOvalPath.stroke()

        context.restoreGState()


        //// DaysOval Drawing
        context.saveGState()
        context.translateBy(x: 93.09, y: 216.22)
        context.scaleBy(x: 0.5, y: 0.5)

        let daysOvalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 270, height: 272.09))
        context.saveGState()
        daysOvalPath.addClip()
        context.drawLinearGradient(gradient3, start: CGPoint(x: 135, y: 0), end: CGPoint(x: 135, y: 272.09), options: [])
        context.restoreGState()
        UIColor.white.setStroke()
        daysOvalPath.lineWidth = 5
        daysOvalPath.stroke()

        context.restoreGState()


        context.endTransparencyLayer()
        context.restoreGState()


        //// Symbol Drawing
        let symbolRect = CGRect(x: 0, y: 0, width: 320, height: 568)
        context.saveGState()
        context.clip(to: symbolRect)
        context.translateBy(x: symbolRect.minX, y: symbolRect.minY)

        TreatYourselfLanding.drawTreatYourselfLandingCircle(frame: CGRect(origin: .zero, size: symbolRect.size), resizing: .stretch, progressDash: DataStore.sharedInstance.progress, velocityDash: DataStore.sharedInstance.velocity, daysDash: DataStore.sharedInstance.days)
        context.restoreGState()
//
//      
//        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: .beginFromCurrentState, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1, animations: {
//                TreatYourselfLanding.drawTreatYourselfLandingCircle(frame: CGRect(origin: .zero, size: symbolRect.size), resizing: .stretch, progressDash: 0, velocityDash: 0, daysDash: 0)
//                context.setLineDash(phase: 0, lengths: [0, 400])
                
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 2.0, animations: {
//                TreatYourselfLanding.drawTreatYourselfLandingCircle(frame: CGRect(origin: .zero, size: symbolRect.size), resizing: .stretch, progressDash: 300, velocityDash: 200, daysDash: 100)
//                context.setLineDash(phase: 0, lengths: [0, 600])
//            })
//        }, completion: nil)
////
        

        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 128, y: 251, width: 66, height: 67))
        UIColor.white.setFill()
        ovalPath.fill()
        
        context.restoreGState()
        
  
        
        
    }

    



    @objc public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
    
    
}



extension UIColor {
    func blended(withFraction fraction: CGFloat, of color: UIColor) -> UIColor {
        var r1: CGFloat = 1, g1: CGFloat = 1, b1: CGFloat = 1, a1: CGFloat = 1
        var r2: CGFloat = 1, g2: CGFloat = 1, b2: CGFloat = 1, a2: CGFloat = 1

        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return UIColor(red: r1 * (1 - fraction) + r2 * fraction,
            green: g1 * (1 - fraction) + g2 * fraction,
            blue: b1 * (1 - fraction) + b2 * fraction,
            alpha: a1 * (1 - fraction) + a2 * fraction);
    }
}

import UIKit

class Graph: UIViewController {
    
    @IBOutlet weak var barChartView: UIView!
    
    @IBOutlet weak var barChartViewConstrainsOutlet: NSLayoutConstraint!
    @IBOutlet weak var box: UIView!
    var id: String?
    var GraphData: GraphModel?
    var resultDataArray: [String] = []
    var dateDataArray: [String] = []
    let barWidth: CGFloat = 50
    let spaceBetweenBars: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        box.layer.borderWidth = 1.0
        box.layer.borderColor = UIColor.black.cgColor
        box.layer.cornerRadius = 10.0
        GetAPI()
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    func GetAPI() {
        let apiURL = APIList.GraphApi + (id ?? "263")
        print(apiURL)
        
        APIHandler().getAPIValues(type: GraphModel.self, apiUrl: apiURL, method: "GET") { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [self] in
                self.GraphData = data
                print(data)
                self.resultDataArray = data.resultData
                self.dateDataArray = data.dateData
//                    let additionalSpace: CGFloat = 10
                    
                    barChartViewConstrainsOutlet.constant = (CGFloat(dateDataArray.count) * (barWidth + spaceBetweenBars))
                    self.drawBarChart(dataPoints: self.dateDataArray, values: self.resultDataArray)
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Warning", message: "Something Went Wrong", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive) { _ in
                        print("API Error")
                    })
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func drawBarChart(dataPoints: [String], values: [String]) {
        
        let maxValue = values.compactMap { Int($0) }.max() ?? 10
        // Calculate the maximum height for the bars
        
        let maxBarHeight: CGFloat = 500.0 // Replace 200.0 with your desired height

//        let maxBarHeight = barChartView.frame.height
        // Calculate the height of each unit on the Y-axis
        let unitHeight = 400.0 / CGFloat(maxValue)
        for (index, valueString) in values.enumerated() {
            guard let value = Int(valueString) else {
                continue
            }
            
            let barHeight = CGFloat(value) * unitHeight
            
            let barX = CGFloat(index) * (barWidth + spaceBetweenBars)
            let barY = maxBarHeight - barHeight
            
            let barLayer = CALayer()
            barLayer.frame = CGRect(x: barX, y: barY, width: barWidth, height: barHeight)
            barLayer.backgroundColor = UIColor.blue.cgColor
            
            barChartView.layer.addSublayer(barLayer)
            
            // Optionally, add labels for data points
            let label = UILabel(frame: CGRect(x: barX, y: maxBarHeight, width: barWidth, height: 20))
            label.text = dataPoints[index]
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 8)
            barChartView.addSubview(label)
            
            // Display values on top of each bar
            let valueLabel = UILabel(frame: CGRect(x: barX, y: barY - 20, width: barWidth, height: 10))
            valueLabel.text = "\(value)"
            valueLabel.textAlignment = .center
            valueLabel.font = UIFont.systemFont(ofSize: 12)
            barChartView.addSubview(valueLabel)
        }
    }
}

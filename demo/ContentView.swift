import SwiftUI
//你好
struct ContentView: View {
    @State private var isFirstImage = true
    @State private var scale: CGFloat = 0.7
    @State private var rotation: Double = 0
    private func startAnimation() {
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                scale = 0.8
            }
        }
    var body: some View {
        ZStack{
            Image(.background)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity,minHeight: 0, maxHeight:.infinity)
                .ignoresSafeArea()
            ScrollView{
                VStack {
                    VStack {
                        if isFirstImage {
                            pokeInfo(pokeimg: .flittle,pokeimg_shiny: .shinyFlittle, name: "飄飄雛", pokenum: "#0955", story: "飄飄雛會在荒地跑來跑去來度過時間。如果最喜歡的樹果被拿走，就會窮追不捨地展開報復。由腹部的褶邊放射出的精神力量能讓它浮在腳尖距離地面僅有1厘米的空中。",wikiURL: "https://wiki.52poke.com/wiki/飘飘雏" ,HP: 30, ATK: 35, DEF: 30, SPATK: 55, SPDEF: 30, SPD: 75)
                            Text("點擊糖果使其進化")
                                .foregroundColor(Color.white)
                                .font(.custom("CEF-Fonts-CJK", size: 30))
                                .padding()
                            Image(.candy)
                                .scaleEffect(scale)
                                .onAppear {
                                    startAnimation()
                                }
                                .onDisappear {
                                    scale = 0.7
                                }
                                .onTapGesture {
                                    withAnimation {
                                        isFirstImage.toggle()
                                    }
                                }
                                .offset(y:-60)
                        } else {
                            pokeInfo(pokeimg: .espathra,pokeimg_shiny: .shinyEspathra, name: "超能豔鴕", pokenum: "#0956", story: "超能豔鴕與外表不同，性格很兇暴。它大大的眼睛會放出精神力量使對手無法動彈。它還會從彩色的褶邊的縫隙間釋放出精神力量，藉此以時速200公里的速度狂奔。",wikiURL: "https://wiki.52poke.com/wiki/超能艳鸵", HP: 95, ATK: 60, DEF: 60, SPATK: 101, SPDEF: 60, SPD: 105)
                            ZStack{
                                Text("退化")
                                    .foregroundColor(Color.white)
                                    .font(.custom("CEF-Fonts-CJK", size: 20))
                                    .padding()
                                if #available(iOS 18, *) {
                                    Group {
                                        Image(systemName: "arrow.triangle.2.circlepath")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .symbolEffect(.rotate.counterClockwise)
                                            .foregroundStyle(.white)
                                    }
                                } else {
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .rotationEffect(.degrees(rotation))
                                        .onAppear {
                                            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                                rotation = -360
                                            }
                                        }
                                        .foregroundStyle(.white)
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    isFirstImage.toggle()
                                }
                            }
                            
                            
                        }
                    }
                    
                }
                
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ContentView()
}

struct ExtractedView: View {
    let name:String
    let number:Int
    let color:String
    var body: some View {
        HStack{
            Text(name)
                .frame(width: 45, alignment: .center)
                .foregroundColor(colorFromString(color))
            Path { (path) in
                path.move(to: CGPoint(x: 0, y: 12))
                path.addLine(to: CGPoint(x: number, y: 12))
            }
            .stroke(colorFromString(color), style: StrokeStyle(lineWidth: 12, lineCap: .round))
            Text(String(number))
                .foregroundColor(colorFromString(color))
                .padding(.trailing, 80)
        }
        .font(.system(size: 20))
        .padding(.leading, 80)
    }
    func colorFromString(_ colorName: String) -> Color {
        switch colorName {
        case "red":
            return .red
        case "green":
            return .green
        case "blue":
            return .blue
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "purple":
            return .purple
        case "cyan": // 天藍色
            return .cyan
        default:
            return .black // 默認顏色
        }
    }
}

struct pokeInfo: View {
    @State private var isShiny = false
    let pokeimg:ImageResource
    let pokeimg_shiny:ImageResource
    let name:String
    let pokenum:String
    let story:String
    let wikiURL:String
    let HP:Int
    let ATK:Int
    let DEF:Int
    let SPATK:Int
    let SPDEF:Int
    let SPD:Int
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                if(!isShiny){
                    Image(pokeimg)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .transition(.opacity)
                }
                else{
                    ZStack{
                        Image(pokeimg_shiny)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .transition(.opacity)
                        Image(.shiny)
                            .offset(x:120,y:120)
                    }
                    
                }
            }
            .offset(x:65)
            .onTapGesture {
                withAnimation {
                    isShiny.toggle()
                }
            }
            
        }
        
        HStack{
            Text(name)
                .font(.custom("CEF-Fonts-CJK", size: 30))
                .foregroundColor(Color.white)
            Text(pokenum)
                .font(.custom("CEF-Fonts-CJK", size: 30))
                .foregroundColor(Color.white)
        }
        HStack{
            Text("屬性")
                .foregroundColor(Color.white)
            HStack(spacing:0){
                Image("Psychic")
                    .resizable()
                    .frame(width: 20.0, height: 20.0)
                Text("超能力")
                    .foregroundColor(Color.pink)
            }
        }
        .font(.system(size: 25))
        .padding()
        VStack{
            Text("概述")
                .font(.system(size: 25))
                .foregroundColor(Color.white)
            
            Text(story)
                .foregroundColor(Color.white)
                .font(.custom("CEF-Fonts-CJK", size: 30))
            Link("點擊前往pokewiki", destination: URL(string: wikiURL)!)
                .foregroundColor(Color.white)
                .font(.custom("CEF-Fonts-CJK", size: 20))
        }
        .padding()
        .background(Color.pink.opacity(0.2))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.purple, lineWidth: 2)
        )
        .padding()
        VStack{
            Text("種族值")
                .font(.custom("CEF-Fonts-CJK", size: 30))
                .foregroundColor(Color.white)
            ExtractedView(name:"HP",number:HP,color:"green")
            ExtractedView(name:"攻擊",number:ATK,color:"yellow")
            ExtractedView(name:"防禦",number:DEF,color:"orange")
            ExtractedView(name:"特攻",number:SPATK,color:"cyan")
            ExtractedView(name:"特防",number:SPDEF,color:"blue")
            ExtractedView(name:"速度",number:SPD,color:"purple")
        }
    }
}

//
//  DashboardView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 22.07.2023.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    
    @Query private var budgets: [Budget]
    @Query private var accounts: [Account]
    @Query private var goals: [Goal]
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Section {
                        TabView {
                            
                            if budgets.isEmpty {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(.systemGray6))
                                    
                                    CustomNoContentView(
                                        imageName: "dollarsign",
                                        message: "You don't have any Budgets yet",
                                        buttonLabel: "Create one!",
                                        sheetContent: AnyView(
                                            NavigationStack {
                                                CreateBudgetView()
                                            }.presentationDetents([.medium])
                                        )
                                    )
                                    
                                }
                            } else {
                                ForEach(budgets) { budget in
                                    VStack(alignment: .leading) {
                                        Text(budget.name).font(.title2).fontWeight(.bold)
                                        ZStack(alignment: .center) {
 
                                            
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(LinearGradient(
                                                    gradient: .init(colors: [Color(hex: "#4e6abe"), Color(hex: "#3252b3")]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                  ))
                                            
 
                                            
                                            Text("Test")
                                                .font(.largeTitle)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.white)
                                                .multilineTextAlignment(.center)
                                        }//: ZStack
                                    }//:VStack
                                    .padding([.leading, .trailing], 5)
                                }//: FOREACH
                            }
                            
                            
                        }//: TABVIEW
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }//: SECTION
                    .frame(height: 175)
                    
                    Divider()
                    
                    Section {
                        VStack(alignment: .leading) {
                            HStack{
                                Text("Accounts").font(.title2).fontWeight(.bold)
                                Spacer()
                                NavigationLink {
                                    AccountsView()
                                }label: {
                                    Text("See All")
                                }
                            }
                            
                            Text("Organize Your Money with Accounts!").foregroundColor(.gray)

 
                            
                        }
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(accounts) { account in
                                    
                                    NavigationLink {
                                        AccountDetailView(account: account)
                                    } label: {
                                        ZStack(alignment: .leading) {
                                            RoundedRectangle(cornerRadius: 15)                         // Shapes are resizable by default
                                                .fill(LinearGradient(
                                                    gradient: .init(colors: [Color(hex: "#ee696e"), Color(hex: "#ec5157")]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                  ))
                                                    
                                            
                                            VStack(alignment: .leading) {
                                                HStack {
                                                    Text(account.name)
                                                        .font(.title2)
                                                        .fontWeight(.semibold)
                                                    Spacer()
                                                    Image(systemName: "chart.line.uptrend.xyaxis")
                                                        .fontWeight(.bold)
                                                        .frame(width: 10, height: 10)
                                                        .padding(10)
                                                        .background(Color.white.opacity(0.3))
                                                        .clipShape(Circle())
                                                }
                                                Spacer()
                                                Text(account.nettoAmount.asCurrency())

                                            }.foregroundStyle(.white)
                                            .padding()
                                            
                                            
                                            
                                        }
                                        .frame(height: 100)
                                        .frame(width: 150)
                                        .padding([.leading, .trailing], 2.5)
                                    }
                                }//: FOREACH
                            }
                            
                        }//: TABVIEW
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                    
                    Divider()
                    
                    Section {
                        
                        VStack(alignment: .leading) {
                            HStack{
                                Text("Goals").font(.title2).fontWeight(.bold)
                                Spacer()
                                NavigationLink {
                                    AccountsView()
                                }label: {
                                    Text("See All")
                                }
                            }
                            
                            Text("Achieve More with Financial Goals!").foregroundColor(.gray)

 
                            
                        }
                        
                        ScrollView(.horizontal) {
                            LazyHStack {
                                if goals.isEmpty {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(.systemGray6))
                                        CustomNoContentView(
                                            imageName: "flag.checkered",
                                            message: "You don't have any Goals yet",
                                            buttonLabel: "Create one!",
                                            sheetContent: AnyView(
                                                NavigationStack {
                                                    CreateGoalView()
                                                }.presentationDetents([.medium])
                                            )
                                        )
                                    }
                                }
                                ForEach(goals) { goal in
                                    NavigationLink {
                                        
                                    } label: {
                                        ZStack(alignment: .center) {
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color(.systemGray6))
                                            Text(goal.name)
                                                .font(.largeTitle)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.white)
                                                .multilineTextAlignment(.center)
                                        }.frame(height: 100)
                                            .frame(width: 150)
                                            .padding([.leading, .trailing], 2.5)
                                    }
                                }//: FOREACH
                            }
                        }//: TABVIEW
                        .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                }//: VSTACK
                .padding()
            }//: SCROLL
            .navigationTitle("Dashboard")
            .toolbar {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "person.crop.circle")
                }
                
            }
        }
    }
}

#Preview {
    DashboardView()
}

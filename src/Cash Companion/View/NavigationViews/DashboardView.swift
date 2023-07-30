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
    
    
    @State private var selectedTab = 4
    
    var body: some View {
        NavigationView {
            
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Section {
                            TabView {
                                
                                if goals.isEmpty {
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
                                                    .fill(Color(.systemGray6))
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
                            HStack {
                                VStack{
                                    Text("Accounts").font(.title2).fontWeight(.bold)
                                }
                                Spacer()
                                
                                NavigationLink {
                                    AccountsView()
                                }label: {
                                    Text("See All")
                                }
                                
                            }
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(accounts) { account in
                                        
                                        ZStack(alignment: .center) {
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color(.systemGray6))
                                            
                                            Text(account.name)
                                                .font(.largeTitle)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color.white)
                                                .multilineTextAlignment(.center)
                                            
                                            
                                        }.frame(height: 100)
                                            .frame(width: 150)
                                            .padding([.leading, .trailing], 2.5)
                                        
                                        
                                    }//: FOREACH
                                }
                                
                            }//: TABVIEW
                            .tabViewStyle(.page)
                            .indexViewStyle(.page(backgroundDisplayMode: .always))
                        }
                        
                        Divider()
                        
                        Section {
                            HStack {
                                VStack{
                                    Text("Goals").font(.title2).fontWeight(.bold)
                                }
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Text("See All")
                                }
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
        }
    }
}

#Preview {
    DashboardView()
}

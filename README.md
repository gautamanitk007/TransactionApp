# TransactionApp
This App Architecture is based on VIP(View, Interactor and Presenter).

Clean Swift (VIP) was first introduced by Raymond Law on his website clean-swift.com. 
The idea behind it was to tackle the Massive view controller problem while following the main ideas found in Uncle Bob’s Clean Architecture.

Note:

1.Way to test this app in offline mode:
   Go to AppDelegate and set-> TransactionManager.shared.enableMock = true
   
   
2.Don't set  TransactionManager.shared.enableMock = true in AppDelegate while running the test case
  I will add support for this after 25th Nov 2021 
  

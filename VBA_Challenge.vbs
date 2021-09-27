Attribute VB_Name = "Module1"
Sub AllStocksAnalysisRefactored()
    Dim startTime As Single
    Dim endTime  As Single

    yearValue = InputBox("What year would you like to run the analysis on?")

    startTime = Timer
    
    
   'Format the output sheet on All Stocks Analysis worksheet
    Worksheets("All Stocks Analysis").Activate
    
    Range("A1").Value = "All Stocks (" + yearValue + ")"
    
    'Create a header row
    Cells(3, 1).Value = "Ticker"
    Cells(3, 2).Value = "Total Daily Volume"
    Cells(3, 3).Value = "Return"

    'Initialize array of all tickers
    Dim tickers(11) As String
    tickers(0) = "AY"
    tickers(1) = "CSIQ"
    tickers(2) = "DQ"
    tickers(3) = "ENPH"
    tickers(4) = "FSLR"
    tickers(5) = "HASI"
    tickers(6) = "JKS"
    tickers(7) = "RUN"
    tickers(8) = "SEDG"
    tickers(9) = "SPWR"
    tickers(10) = "TERP"
    tickers(11) = "VSLR"
    
    
    'Activate data worksheet
    Worksheets(yearValue).Activate
    
    'xx1) Initialize variables for starting price and ending price
    Dim startingPrice As Double
    Dim endingPrice As Double
    
    'Get the number of rows to loop over
    RowCount = Cells(Rows.Count, "A").End(xlUp).Row
    
    '1a) Create a ticker Index
    TickerIndex = tickers(0)
    
    '1b) Create three output arrays
       Dim tickerVolume(11) As Long
       Dim stockReturn(11) As Double

        
    '2a) Create a for loop to initialize the tickerVolumes to zero.
    
    For i = 0 To 11
       TickerIndex = tickers(i)
       totalVolume = 0
       
       '2b) Loop over all the rows in the spreadsheet.
       Worksheets(yearValue).Activate
       For j = 2 To RowCount

           '3a) Increase volume for current ticker
           If Cells(j, 1).Value = TickerIndex Then

               totalVolume = totalVolume + Cells(j, 8).Value

           End If
           
           '3b) Check if the current row is the first row with the selected tickerIndex.
           If Cells(j - 1, 1).Value <> TickerIndex And Cells(j, 1).Value = TickerIndex Then

               startingPrice = Cells(j, 6).Value

           End If

           '3c) check if the current row is the last row with the selected ticker
           'If the next row’s ticker doesn’t match, '3d)increase the tickerIndex.
           If Cells(j + 1, 1).Value <> TickerIndex And Cells(j, 1).Value = TickerIndex Then

               endingPrice = Cells(j, 6).Value

           End If
       Next j
       
       '4) Loop through your arrays to output the Ticker, Total Daily Volume, and Return.
       Worksheets("All Stocks Analysis").Activate
       Cells(4 + i, 1).Value = TickerIndex
       Cells(4 + i, 2).Value = totalVolume
       Cells(4 + i, 3).Value = endingPrice / startingPrice - 1

   Next i

    'Formatting
    Worksheets("All Stocks Analysis").Activate
    Range("A3:C3").Font.FontStyle = "Bold"
    Range("A3:C3").Borders(xlEdgeBottom).LineStyle = xlContinuous
    Range("B4:B15").NumberFormat = "#,##0"
    Range("C4:C15").NumberFormat = "0.0%"
    Columns("B").AutoFit

    dataRowStart = 4
    dataRowEnd = 15

    For i = dataRowStart To dataRowEnd
        
        If Cells(i, 3) > 0 Then
            
            Cells(i, 3).Interior.Color = vbGreen
            
        Else
        
            Cells(i, 3).Interior.Color = vbRed
            
        End If
        
    Next i
 
    endTime = Timer
    MsgBox "This code ran in " & (endTime - startTime) & " seconds for the year " & (yearValue)
    
End Sub

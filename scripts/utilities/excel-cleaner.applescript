#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Excel Cleaner
# @raycast.mode silent
# @raycast.packageName |  Helpers

# Optional parameters:
# @raycast.icon /Applications/Microsoft Excel.app/Contents/Resources/XCEL.icns

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description It will perform multiple Excel formatting steps

-- Function to open the most recent CSV file from Downloads folder

on openMostRecentCSV()
	set downloadsFolder to POSIX path of (path to downloads folder) -- Get the absolute path to the Downloads folder
    set csvFiles to {}

	try
		set allFiles to list folder downloadsFolder
		set csvFiles to {}

		repeat with aFile in allFiles
			if aFile ends with ".csv" or aFile ends with ".tsv" or aFile ends with ".xls" then
				set end of csvFiles to aFile as text
			end if
		end repeat
		
	on error errMsg
		display dialog "Error: " & errMsg buttons {"OK"} default button "OK"
	end try

    
    -- Check if there are any CSV files
    if (count of csvFiles) > 0 then
        -- Get the most recent CSV file
        set mostRecentCSV to last item of csvFiles
        set csvPath to downloadsFolder & mostRecentCSV
        
        -- Open the CSV file in Excel
        tell application "Microsoft Excel"
            activate
            open csvPath
        end tell
    else
        display dialog "No CSV files found in Downloads folder."
    end if
end openMostRecentCSV

on cleanCSV()
	-- This script activates Microsoft Excel and performs various tasks on the active sheet
	tell application "Microsoft Excel"
		activate

	-- Color
		tell active sheet
			set color of interior object of range "1:1" to {195, 215, 235}
		end tell

	-- Freeze
		tell application "System Events" 
			key code 32 using {control down, shift down}
		end tell
		try
			select row 2 of active sheet
			set freeze panes of active window to true
		on error
			display dialog "Unable to select row 2 and freeze panes. Please check the active sheet and try again."
		end try

	-- Filter
		tell range "1:1" of active sheet
			autofilter range
		end tell

-- Autofit
    set activeWorkbook to active workbook
    set workbookName to name of activeWorkbook
    if workbookName contains "History" then
		set column width of range "A:A" to 15
		set column width of range "B:C" to 8
		set column width of range "D:E" to 14		
		set column width of range "F:F" to 22
		set column width of range "G:G" to 40
		set column width of range "H:H" to 20		
		set column width of range "I:I" to 14
		set column width of range "J:J" to 40
		autofit column "L:L"
		set column width of range "M:M" to 40		

	else
		autofit column "A:L"

	end if

-- Unwrap text
	tell used range of active sheet
		set wrap text to false
	end tell

	select range ("A1:A1")

	select range ("A1:A1")

	end tell
end cleanCSV

try
	cleanCSV()

on error errMsg
    -- Check if the error is due to the sheet not existing
    if errMsg contains "The object you are trying to access does not exist" then
        -- Handle the error by opening the most recent CSV file
        openMostRecentCSV()
		cleanCSV()

    else
        -- Display other errors
        display dialog "An error occurred: " & errMsg
    end if
end try

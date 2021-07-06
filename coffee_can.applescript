--
-- Gets crypto prices from coingecko api
-- Requires JSON Helper - you can get it here https://apps.apple.com/gb/app/json-helper-for-applescript/id453114608?mt=12
-- The sheet has 4 columns token, api id, price, last update
-- Use the api to find the id for the token https://api.coingecko.com/api/v3/coins/list?include_platform=false
--
set docName to "coffee can example"
set shtName to "prices"
set tblName to "coingecko"

tell application "Numbers"
	activate
	tell the table tblName of sheet shtName of document docName
		repeat with i from 2 to (count of cells of column "B") - 1
			set sym to (value of cell "B2")
			if sym is not missing value then
				set coingecko_url to "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=" & (value of cell i of column "B")
				tell application "JSON Helper" to set json to fetch JSON from coingecko_url
				set cp to current_price of json's 1st item
				set lu to last_updated of json's 1st item
				set value of cell i of column "C" to cp
				set value of cell i of column "E" to lu
			end if
		end repeat
	end tell
end tell

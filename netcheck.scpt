set cnt to 0
repeat
	try
		set ping to (do shell script "ping -c 2 -W 1000 qq.com ")
	on error
		display notification "ping error"
	end try
	if ping contains "timeout" then
		set cnt to cnt + 1
		log cnt
		if (cnt) = 2 then
			display notification "网络故障"
			set cnt to 0
		end if
	else
		set cnt to 0
	end if
	delay 3
end repeat


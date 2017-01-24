function randseed(seedchoice)

if (seedchoice > (4e9)) || (seedchoice < 0)
   seedchoice = 5403477918
   disp('using my default seed')
else
   disp('my seed is')
   seedchoice
    
end

rand('state', seedchoice)
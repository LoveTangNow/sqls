
--上海
select ta.fbin, t.fcode, ta.fqtystr, ta.fowner, ta.flot, ta.fproducedate
  from tbinarticles ta
  left join tarticle t on t.fgid = ta.farticle
 where ta.flot = '-'
   and (ta.fbin like '20%' or ta.fbin like '21%' or ta.fbin like '91%' or
       ta.fbin like '92%')
   and ta.fowner = 100081;


--北京
select ta.fbin, t.fcode, ta.fqtystr, ta.fowner, ta.flot, ta.fproducedate
  from tbinarticles ta
  left join tarticle t on t.fgid = ta.farticle
 where ta.flot = '-'
   and (ta.fbin like '11%' or ta.fbin like '93%' or ta.fbin like '94%' )
   and ta.fowner = 100161;

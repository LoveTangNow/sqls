--在单量库存 处理

select * from tbinarticles t where t.fbin = '21012521'


select * from tbin where tbin.fcode  = '21012521'


--11092212
select * from tarticlecode tc where tc.fbarcode = '320500100166'


select * from tbinartbill where tbinartbill.fbin = '21012521'
delete from tbinartbill where tbinartbill.fbin = '21012521'


select * from collate where collate.tablename = 'TBINARTBILL'
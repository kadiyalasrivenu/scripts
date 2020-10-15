#!/usr/sbin/dtrace -s

#pragma D option quiet

tcp:::send
{
	snxt[args[1]->cs_cid, args[3]->tcps_snxt] = timestamp;
	@bytesrtt[args[2]->ip_daddr] =
	    sum(args[2]->ip_plength - args[4]->tcp_offset);
	@countrtt[args[2]->ip_daddr] = count();
}

tcp:::receive
/ snxt[args[1]->cs_cid, args[4]->tcp_ack] /
{
	@meanrtt[args[2]->ip_saddr] = 
	    avg(timestamp - snxt[args[1]->cs_cid, args[4]->tcp_ack]);
	@stddevrtt[args[2]->ip_saddr] =
	    stddev(timestamp - snxt[args[1]->cs_cid, args[4]->tcp_ack]);
	snxt[args[1]->cs_cid, args[4]->tcp_ack] = 0;
}

END
{
	printf("%-25s %-15s %-15s %-10s %-10s\\n",
	    "Remote host", "TCP Avg RTT(ns)", "StdDev", "NumBytes", "NumSegs");
	printa("%-25s %@-15d %@-15d %@-10d %@-10d\\n",
	    @meanrtt, @stddevrtt, @bytesrtt, @countrtt);
}

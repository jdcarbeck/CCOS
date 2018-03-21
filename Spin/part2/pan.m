#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC P */
	case 3: // STATE 1 - philo.pml:26 - [((fork[id]==0))] (19:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!((((int)now.fork[ Index(((int)((P1 *)this)->id), 5) ])==0)))
			continue;
		/* merge: fork[id] = (id+1)(0, 2, 19) */
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.fork[ Index(((int)((P1 *)this)->id), 5) ]);
		now.fork[ Index(((P1 *)this)->id, 5) ] = (((int)((P1 *)this)->id)+1);
#ifdef VAR_RANGES
		logval("fork[P:id]", ((int)now.fork[ Index(((int)((P1 *)this)->id), 5) ]));
#endif
		;
		/* merge: .(goto)(0, 8, 19) */
		reached[1][8] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 4 - philo.pml:30 - [((fork[((id+1)%5)]==0))] (19:0:1 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		if (!((((int)now.fork[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ])==0)))
			continue;
		/* merge: fork[((id+1)%5)] = (id+1)(0, 5, 19) */
		reached[1][5] = 1;
		(trpt+1)->bup.oval = ((int)now.fork[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]);
		now.fork[ Index(((((P1 *)this)->id+1)%5), 5) ] = (((int)((P1 *)this)->id)+1);
#ifdef VAR_RANGES
		logval("fork[((P:id+1)%5)]", ((int)now.fork[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]));
#endif
		;
		/* merge: .(goto)(0, 8, 19) */
		reached[1][8] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 5: // STATE 9 - philo.pml:38 - [((fork[id]==(id+1)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		if (!((((int)now.fork[ Index(((int)((P1 *)this)->id), 5) ])==(((int)((P1 *)this)->id)+1))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 10 - philo.pml:39 - [((fork[((id+1)%5)]==0))] (23:0:2 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		if (!((((int)now.fork[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ])==0)))
			continue;
		/* merge: fork[((id+1)%5)] = (id+1)(23, 11, 23) */
		reached[1][11] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.fork[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]);
		now.fork[ Index(((((P1 *)this)->id+1)%5), 5) ] = (((int)((P1 *)this)->id)+1);
#ifdef VAR_RANGES
		logval("fork[((P:id+1)%5)]", ((int)now.fork[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]));
#endif
		;
		/* merge: p_eating = (p_eating+1)(23, 12, 23) */
		reached[1][12] = 1;
		(trpt+1)->bup.ovals[1] = ((int)p_eating);
		p_eating = (((int)p_eating)+1);
#ifdef VAR_RANGES
		logval("p_eating", ((int)p_eating));
#endif
		;
		/* merge: .(goto)(0, 20, 23) */
		reached[1][20] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 7: // STATE 14 - philo.pml:44 - [((fork[id]==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][14] = 1;
		if (!((((int)now.fork[ Index(((int)((P1 *)this)->id), 5) ])==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 15 - philo.pml:45 - [((fork[((id+1)%5)]==(id+1)))] (23:0:2 - 1)
		IfNotBlocked
		reached[1][15] = 1;
		if (!((((int)now.fork[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ])==(((int)((P1 *)this)->id)+1))))
			continue;
		/* merge: fork[id] = (id+1)(23, 16, 23) */
		reached[1][16] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.fork[ Index(((int)((P1 *)this)->id), 5) ]);
		now.fork[ Index(((P1 *)this)->id, 5) ] = (((int)((P1 *)this)->id)+1);
#ifdef VAR_RANGES
		logval("fork[P:id]", ((int)now.fork[ Index(((int)((P1 *)this)->id), 5) ]));
#endif
		;
		/* merge: p_eating = (p_eating+1)(23, 17, 23) */
		reached[1][17] = 1;
		(trpt+1)->bup.ovals[1] = ((int)p_eating);
		p_eating = (((int)p_eating)+1);
#ifdef VAR_RANGES
		logval("p_eating", ((int)p_eating));
#endif
		;
		/* merge: .(goto)(0, 20, 23) */
		reached[1][20] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 9: // STATE 23 - philo.pml:52 - [D_STEP52]
		IfNotBlocked

		reached[1][23] = 1;
		reached[1][t->st] = 1;
		reached[1][tt] = 1;

		if (TstOnly) return 1;

		sv_save();
		S_031_0: /* 2 */
		p_eating = (((int)p_eating)-1);
#ifdef VAR_RANGES
		logval("p_eating", ((int)p_eating));
#endif
		;
S_032_0: /* 2 */
		now.fork[ Index(((((P1 *)this)->id+1)%5), 5) ] = 0;
#ifdef VAR_RANGES
		logval("fork[((P:id+1)%5)]", ((int)now.fork[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]));
#endif
		;
		goto S_034_0;
S_034_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 10: // STATE 24 - philo.pml:56 - [fork[id] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][24] = 1;
		(trpt+1)->bup.oval = ((int)now.fork[ Index(((int)((P1 *)this)->id), 5) ]);
		now.fork[ Index(((P1 *)this)->id, 5) ] = 0;
#ifdef VAR_RANGES
		logval("fork[P:id]", ((int)now.fork[ Index(((int)((P1 *)this)->id), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 11: // STATE 1 - philo.pml:14 - [i = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)this)->_1_1_i);
		((P0 *)this)->_1_1_i = 0;
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P0 *)this)->_1_1_i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 2 - philo.pml:15 - [((i<5))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		if (!((((int)((P0 *)this)->_1_1_i)<5)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 3 - philo.pml:15 - [(run P(i))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		if (!(addproc(II, 1, 1, ((int)((P0 *)this)->_1_1_i))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 4 - philo.pml:15 - [i = (i+1)] (0:0:1 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		(trpt+1)->bup.oval = ((int)((P0 *)this)->_1_1_i);
		((P0 *)this)->_1_1_i = (((int)((P0 *)this)->_1_1_i)+1);
#ifdef VAR_RANGES
		logval(":init::i", ((int)((P0 *)this)->_1_1_i));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 15: // STATE 11 - philo.pml:19 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}


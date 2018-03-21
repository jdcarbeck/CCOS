	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC P */

	case 3: // STATE 2
		;
		now.fork[ Index(((P1 *)this)->id, 5) ] = trpt->bup.oval;
		;
		goto R999;

	case 4: // STATE 5
		;
		now.fork[ Index(((((P1 *)this)->id+1)%5), 5) ] = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 6: // STATE 12
		;
		p_eating = trpt->bup.ovals[1];
		now.fork[ Index(((((P1 *)this)->id+1)%5), 5) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
;
		;
		
	case 8: // STATE 17
		;
		p_eating = trpt->bup.ovals[1];
		now.fork[ Index(((P1 *)this)->id, 5) ] = trpt->bup.ovals[0];
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;
	case 9: // STATE 23
		sv_restor();
		goto R999;

	case 10: // STATE 24
		;
		now.fork[ Index(((P1 *)this)->id, 5) ] = trpt->bup.oval;
		;
		goto R999;

		 /* PROC :init: */

	case 11: // STATE 1
		;
		((P0 *)this)->_1_1_i = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 13: // STATE 3
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 14: // STATE 4
		;
		((P0 *)this)->_1_1_i = trpt->bup.oval;
		;
		goto R999;

	case 15: // STATE 11
		;
		p_restor(II);
		;
		;
		goto R999;
	}


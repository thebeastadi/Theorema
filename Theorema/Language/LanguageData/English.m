
With[ {lang = "English"},
	MessageName[QU$, "usage", lang] = "A marker introduced during the parsing process that temporarily marks quantified variables.";
	MessageName[VAR$, "usage", lang] = "";
	MessageName[RNG$, "usage", lang] = "";
	MessageName[SIMPRNG$, "usage", lang] = "SIMPRNG$[ x_] usually denotes that the variable x ranges over the universe.";
	MessageName[SETRNG$, "usage", lang] = "SETRNG$[ x_, s_] denotes that the variable x ranges over the set s.";
	MessageName[PREDRNG$, "usage", lang] = "PREDRNG$[ x_, p_] denotes that the variable x satisfies the predicate p.";
	MessageName[STEPRNG$, "usage", lang] = "STEPRNG$[ x_, low_, high_, step_] denotes that the variable x steps from low to high in steps of step.";
	MessageName[EqualDef$TM, "usage", lang] = "";
	MessageName[IffDef$TM, "usage", lang] = "";
	MessageName[Equal$TM, "usage", lang] = "";
	MessageName[Not$TM, "usage", lang] = "";
	MessageName[Iff$TM, "usage", lang] = "";
	MessageName[Implies$TM, "usage", lang] = "";
	MessageName[And$TM, "usage", lang] = "";
	MessageName[Or$TM, "usage", lang] = "";
	MessageName[Forall$TM, "usage", lang] = "";
	MessageName[Exists$TM, "usage", lang] = "";
	MessageName[Plus$TM, "usage", lang] = "";
	MessageName[Times$TM, "usage", lang] = "";
	MessageName[Less$TM, "usage", lang] = "";
	MessageName[LessEqual$TM, "usage", lang] = "";
	MessageName[Greater$TM, "usage", lang] = "";
	MessageName[GreaterEqual$TM, "usage", lang] = "";
	MessageName[IntersectionOf$TM, "usage", lang] = "";
	MessageName[Union$TM, "usage", lang] = "";
	MessageName[Tuple$TM, "usage", lang] = "";	
	MessageName[TupleOf$TM, "usage", lang] = "";	
	MessageName[Set$TM, "usage", lang] = "";	
	MessageName[SetOf$TM, "usage", lang] = "";	
	MessageName[SequenceOf$TM, "usage", lang] = "";	
    (* Mathematica programming language *)
	MessageName[Program, "usage", lang] = "";	
	MessageName[Module$TM, "usage", lang] = "";	
	MessageName[CompoundExpression$TM, "usage", lang] = "";	
	MessageName[Assign$TM, "usage", lang] = "";	
	MessageName[SetDelayed$TM, "usage", lang] = "";	
	MessageName[Do$TM, "usage", lang] = "";	
	MessageName[While$TM, "usage", lang] = "";	
	MessageName[For$TM, "usage", lang] = "";	
	MessageName[If$TM, "usage", lang] = "";	
	MessageName[Which$TM, "usage", lang] = "";	
	MessageName[Switch$TM, "usage", lang] = "";	
	MessageName[List$TM, "usage", lang] = "";
	(* Global declarations *)	
	MessageName[globalForall$TM, "usage", lang] = "globalForall$TM[ rng_, cond_, decl_] is a datastructure representing a (nested) global universal variable, where 
	\*StyleBox[\"decl\", FontSlant -> \"Italic\"] contains further global declarations. globalForall$TM[ rng_, cond_] is a single global universal variable.";
	MessageName[globalImplies$TM, "usage", lang] = "globalImplies$TM[ cond_, decl_] is a datastructure representing a (nested) global condition, where
	\*StyleBox[\"decl\", FontSlant -> \"Italic\"] contains further global declarations. globalImplies$TM[ cond_] is a single global condition.";
	
]


(* Theorema 
    Copyright (C) 2010 The Theorema Group

    This file is part of Theorema.2
    
    Theorema.2 is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Theorema.2 is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*)

With[ {lang = "English"},
	MessageName[FIX$, "usage", lang] = "";
	MessageName[META$, "usage", lang] = "";
	MessageName[QU$, "usage", lang] = "QU$[ expr] temporarily marks quantified variables in expr.";
	MessageName[VAR$, "usage", lang] = "";
	MessageName[SEQ0$, "usage", lang] = "";
	MessageName[SEQ1$, "usage", lang] = "";
	MessageName[RNG$, "usage", lang] = "";
	MessageName[SIMPRNG$, "usage", lang] = "SIMPRNG$[ x] usually denotes that the variable x ranges over the universe.";
	MessageName[SETRNG$, "usage", lang] = "SETRNG$[ x, s] denotes that the variable x ranges over the set s.";
	MessageName[PREDRNG$, "usage", lang] = "PREDRNG$[ x, p] denotes that the variable x satisfies the predicate p.";
	MessageName[STEPRNG$, "usage", lang] = "STEPRNG$[ x, low, high, step] denotes that the variable x steps from low to high in steps of step.";
	MessageName[DOMEXTRNG$, "usage", lang] = "DOMEXTRNG$[ x, dom] denotes that the variable x extends domain dom (in a domain extension definition).";
	MessageName[ABBRVRNG$, "usage", lang] = "ABBRVRNG$[ a, e] denotes that the variable a abbreviates expression e (in a where-expression).";
	MessageName[EqualDef$TM, "usage", lang] = "";
	MessageName[IffDef$TM, "usage", lang] = "";
	MessageName[Equal$TM, "usage", lang] = "";
	MessageName[SetEqual$TM, "usage", lang] = "";
	MessageName[Not$TM, "usage", lang] = "";
	MessageName[Iff$TM, "usage", lang] = "";
	MessageName[Implies$TM, "usage", lang] = "";
	MessageName[And$TM, "usage", lang] = "";
	MessageName[Or$TM, "usage", lang] = "";
	MessageName[Forall$TM, "usage", lang] = "";
	MessageName[Exists$TM, "usage", lang] = "";
	MessageName[Such$TM, "usage", lang] = "";
	MessageName[SuchUnique$TM, "usage", lang] = "";
	MessageName[MinimumOf$TM, "usage", lang] = "";
	MessageName[MaximumOf$TM, "usage", lang] = "";
	MessageName[SumOf$TM, "usage", lang] = "";
	MessageName[ProductOf$TM, "usage", lang] = "";
	MessageName[IntegralOf$TM, "usage", lang] = "";
	MessageName[Abbrev$TM, "usage", lang] = "";
	MessageName[Plus$TM, "usage", lang] = "";
	MessageName[Subtract$TM, "usage", lang] = "";
	MessageName[Times$TM, "usage", lang] = "";
	MessageName[Divide$TM, "usage", lang] = "";
	MessageName[Power$TM, "usage", lang] = "";
	MessageName[Radical$TM, "usage", lang] = "";
	MessageName[Factorial$TM, "usage", lang] = "";
	MessageName[Less$TM, "usage", lang] = "";
	MessageName[LessEqual$TM, "usage", lang] = "";
	MessageName[Greater$TM, "usage", lang] = "";
	MessageName[GreaterEqual$TM, "usage", lang] = "";
	MessageName[Element$TM, "usage", lang] = "";
	MessageName[IntersectionOf$TM, "usage", lang] = "";
    MessageName[Intersection$TM, "usage", lang] = "";
    MessageName[Backslash$TM, "usage", lang] = "";
    MessageName[EmptyUpTriangle$TM, "usage", lang] = "";
    MessageName[\[ScriptCapitalP]$TM, "usage", lang] = "";
    MessageName[SubsetEqual$TM, "usage", lang] = "";
    MessageName[SupersetEqual$TM, "usage", lang] = "";
    MessageName[Superset$TM, "usage", lang] = "";
    MessageName[Subset$TM, "usage", lang] = "";
    MessageName[Cross$TM, "usage", lang] = "";
    MessageName[max$TM, "usage", lang] = "";
    MessageName[min$TM, "usage", lang] = "";
	MessageName[Union$TM, "usage", lang] = "";
	MessageName[Tuple$TM, "usage", lang] = "";	
	MessageName[TupleOf$TM, "usage", lang] = "";	
	MessageName[BracketingBar$TM, "usage", lang] = "";	
	MessageName[Subscript$TM, "usage", lang] = "";	
	MessageName[LeftArrow$TM, "usage", lang] = "";
	MessageName[LeftArrowBar$TM, "usage", lang] = "";
    MessageName[Rule$TM, "usage", lang] = "";	
	MessageName[Cup$TM, "usage", lang] = "";	
    MessageName[Cap$TM, "usage", lang] = "";	
    MessageName[CupCap$TM, "usage", lang] = "";	
	MessageName[MinimumOf$TM, "usage", lang] = "";	
	MessageName[MaximumOf$TM, "usage", lang] = "";
    MessageName[Element$TM, "usage", lang] = "";	
	MessageName[min$TM, "usage", lang] = "";	
	MessageName[max$TM, "usage", lang] = "";	
	MessageName[Set$TM, "usage", lang] = "";	
	MessageName[SetOf$TM, "usage", lang] = "";	
	MessageName[SequenceOf$TM, "usage", lang] = "";	
	MessageName[isInteger$TM, "usage", lang] = "";
	MessageName[isRational$TM, "usage", lang] = "";
	MessageName[isReal$TM, "usage", lang] = "";
	MessageName[isComplex$TM, "usage", lang] = "";
	MessageName[isSet$TM, "usage", lang] = "";
	MessageName[isTuple$TM, "usage", lang] = "";
	MessageName[IntegerRange$TM, "usage", lang] = "";			
	MessageName[RationalRange$TM, "usage", lang] = "";	
	MessageName[RealRange$TM, "usage", lang] = "";	
	MessageName[\[DoubleStruckCapitalC]$TM, "usage", lang] = "";	
	MessageName[CaseDistinction$TM, "usage", lang] = "";	
	MessageName[Clause$TM, "usage", lang] = "";	
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
	MessageName[globalForall$TM, "usage", lang] = "globalForall$TM[ rng, cond, decl] is a datastructure representing a (nested) global universal variable, where 
	decl contains further global declarations. globalForall$TM[ rng, cond] is a single global universal variable.";
	MessageName[globalAbbrev$TM, "usage", lang] = "globalWhere$TM[ rng, cond, decl] is a datastructure representing a (nested) global abbreviation, where 
	decl contains further global declarations. globalWhere$TM[ rng, cond] is a single global abbreviation.";
	MessageName[globalImplies$TM, "usage", lang] = "globalImplies$TM[ cond, decl] is a datastructure representing a (nested) global condition, where
	decl contains further global declarations. globalImplies$TM[ cond] is a single global condition.";
	MessageName[domainConstruct$TM, "usage", lang] = "domainConstruct$TM[ dom, rng] is a datastructure representing a domain constructor for domain dom being 'the rng such that ...'.";
	
]


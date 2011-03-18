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

BeginPackage["Theorema`Interface`GUI`"];
(* Exported symbols added here with SymbolName::usage *)  

$theoremaGUI::usage = "Theorema GUI structure"
updateKBBrowser::usage = ""
displayKBBrowser::usage = ""

Needs["Theorema`System`Messages`"]
Needs["Theorema`Interface`Language`"]

Begin["`Private`"] (* Begin Private Context *) 


(* ::Section:: *)
(* initGUI *)

initGUI[] := 
	Module[{ }, 
		$kbStruct = {};
		$theoremaGUI = {"Theorema Commander" -> theoremaCommander[]};
	]

(* ::Section:: *)
(* theoremaCommander *)

theoremaCommander[] /; $Notebooks :=
    Module[ {style = Replace[ScreenStyleEnvironment,Options[InputNotebook[], ScreenStyleEnvironment]]},
        CreatePalette[ Dynamic[Refresh[
        	TabView[{
        		translate["tcLangTabLabel"]->TabView[{
        			translate["tcLangTabMathTabLabel"]->Dynamic[Refresh[ langButtons[], TrackedSymbols :> {$buttonNat}]],
        			translate["tcLangTabEnvTabLabel"]->envButtons[]}, Dynamic[$tcLangTab],
        			ControlPlacement->Top],
        		translate["tcProveTabLabel"]->TabView[{
        			translate["tcProveTabKBTabLabel"]->Dynamic[Refresh[displayKBBrowser[],TrackedSymbols :> {$kbStruct}]],
        			translate["tcProveTabBuiltinTabLabel"]->emptyPane[translate["not available"]]}, Dynamic[$tcProveTab],
        			ControlPlacement->Top],
        		translate["tcComputeTabLabel"]->TabView[{
        			translate["tcComputeTabKBTabLabel"]->emptyPane[translate["not available"]],
        			translate["tcComputeTabBuiltinTabLabel"]->emptyPane[translate["not available"]]}, Dynamic[$tcCompTab],
        			ControlPlacement->Top],
        		translate["tcPreferencesTabLabel"]->Row[{translate["tcPrefLanguage"], PopupMenu[Dynamic[$Language], availableLanguages[]]}, Spacer[10]]},
        		Dynamic[$tcTopLevelTab],
        		LabelStyle->{Bold}, ControlPlacement->Left
        	], TrackedSymbols :> {$Language}]],
        	StyleDefinitions -> ToFileName[{"Theorema"}, "GUI.nb"],
        	WindowTitle -> "Theorema Commander",
        	ScreenStyleEnvironment -> style,
        	WindowElements -> {"StatusArea"}]
    ]

emptyPane[text_String:""]:=Pane[text, Alignment->{Center,Center}]
 
(* ::Subsubsection:: *)
(* extractKBStruct *)

(*
Documentation see /ProgrammersDoc/GUIDoc.nb#496401653
*)

extractKBStruct[nb_NotebookObject] := extractKBStruct[ NotebookGet[nb]];

extractKBStruct[nb_Notebook] :=
    Module[ {posTit = Cases[Position[nb, Cell[_, "Title", ___]], {a___, 1}],
      posSec = Cases[Position[nb, Cell[_, "Section", ___]], {a___, 1}], 
      posSubsec = Cases[Position[nb, Cell[_, "Subsection", ___]], {a___, 1}], 
      posSubsubsec = Cases[Position[nb, Cell[_, "Subsubsection", ___]], {a___, 1}], 
      posInp = Position[nb, Cell[_, "FormalTextInputFormula", ___]], inputs, depth, sub, root, heads, isolated},
        heads = Join[posSubsubsec, posSubsec, posSec, posTit];
        {inputs, isolated} = Fold[arrangeInput, {Map[List, heads], {}}, posInp];
        depth = Union[Map[Length[#[[1]]] &, inputs]];
        While[Length[depth] > 1,
         sub = Select[inputs, Length[#[[1]]] == depth[[-1]] &];
         root = Select[inputs, Length[#[[1]]] < depth[[-1]] &];
         inputs = Fold[arrangeSub, root, sub];
         depth = Drop[depth, -1];
         ];
        Join[isolated, inputs]
    ]

extractKBStruct[args___] :=
    unexpected[extractKBStruct, {args}]


(* ::Subsubsection:: *)
(* arrangeInput *)

arrangeInput[{struct_, isolated_}, item_] :=
    Module[ {l, root, pos},
        pos = Do[
          root = Drop[struct[[i, 1]], -1];
          l = Length[root];
          If[ Length[item] > l && Take[item, l] == root,
              Return[i]
          ],
          {i, Length[struct]}];
        If[ NumberQ[pos],
            {Insert[struct, item, {pos, -1}], isolated},
            {struct, Insert[isolated, {item}, -1]}
        ]
    ]

arrangeSub[struct_, item : {head_, ___}] :=
    Module[ {l, root, pos},
        pos = Do[
          root = Drop[struct[[i, 1]], -1];
          l = Length[root];
          If[ Length[head] > l && Take[head, l] == root,
              Return[i]
          ],
          {i, Length[struct]}];
        If[ NumberQ[pos],
            Insert[struct, item, {pos, -1}],
            Insert[struct, {item}, 2]
        ]
    ]

(* ::Subsubsection:: *)
(* structView *)
Clear[structView];

structView[file_, {head:Cell[sec_, style:"Title"|"Section"|"Subsection"|"Subsubsection", ___], rest__}, tags_] :=
    Module[ {sub, compTags},
        sub = Transpose[Map[structView[file, #, tags] &, {rest}]];
        compTags = Apply[Union, sub[[2]]];
        {OpenerView[{structView[file, head, compTags], Column[sub[[1]]]}, 
        	ToExpression[StringReplace["Dynamic[NEWSYM]", 
        		"NEWSYM" -> "$kbStructState$"<>FileBaseName[file]<>"$"<>style<>"$"<>ToString[Hash[sec]]]]], 
         compTags}
    ]

structView[file_, {Cell[sec_, style:"Section"|"Subsection"|"Subsubsection", ___]}, tags_] :=
	Sequence[]
 
structView[file_, item_List, tags_] :=
    Module[ {sub, compTags},
        sub = Transpose[Map[structView[file, #, tags] &, item]];
        compTags = Apply[Union, sub[[2]]];
        {Column[sub[[1]]], compTags}
    ]

structView[file_, Cell[content_, "FormalTextInputFormula", ___], tags_] :=
    Sequence[]

structView[file_, Cell[content_, "FormalTextInputFormula", ___, CellTags -> ct_, ___], 
  tags_] :=
  Module[ { isEval = MemberQ[ Theorema`Language`Session`Private`$tmaEnv, {_,ct}, Infinity]},
    {Row[{Checkbox[Dynamic[isSelected[ct]], Enabled->isEval], Hyperlink[ Style[ct, If[ isEval, "FormalTextInputFormula", "FormalTextInputFormulaUneval"]], {file, ct}]}, 
      Spacer[10]], {ct}}
  ]

structView[file_, Cell[content_, style_, ___], tags_] :=
    Module[ {},
        Row[{Checkbox[Dynamic[allTrue[tags], setAll[tags, #] &]], 
          Style[content, style]}, Spacer[10]]
    ]

structView[args___] :=
    unexpected[structView, {args}]

isSelected[_] := False

allTrue[l_] :=
    Catch[Module[ {},
              Scan[If[ Not[TrueQ[isSelected[#]]],
                       Throw[False]
                   ] &, l];
              True
          ]]

setAll[l_, val_] :=
    Scan[(isSelected[#] = val) &, l]

(* ::Subsubsection:: *)
(* updateKBBrowser *)

updateKBBrowser[] :=
    Module[ {file = CurrentValue["NotebookFullFileName"], pos, new},
        pos = Position[ $kbStruct, file -> _];
        new = file -> With[ {nb = NotebookGet[EvaluationNotebook[]]},
                          extractKBStruct[nb] /. l_?VectorQ :> Extract[nb, l]
                      ];
        If[ pos === {},
            AppendTo[ $kbStruct, new],
            $kbStruct[[pos[[1,1]]]] = new
        ]
    ]

(* ::Subsubsection:: *)
(* displayKBBrowser *)
   
displayKBBrowser[] :=
    Module[ {},
        If[ $kbStruct === {},
            emptyPane[translate["No knowledge available"]],
            TabView[
                  Map[Tooltip[Style[FileBaseName[#[[1]]], "NotebookName"], #[[1]]] -> 
                     Pane[structView[#[[1]], #[[2]], {}][[1]], {300, 600}, 
                      ImageSizeAction -> "Scrollable", Scrollbars -> Automatic] &, 
                   $kbStruct], 
                  Appearance -> {"Limited", 10}, FrameMargins->None]
        ]
    ]


(* ::Section:: *)
(* Palettes *)

insertNewEnv[type_String] :=
    Module[ {nb = InputNotebook[]},
        NotebookWrite[
         nb, {Cell[
           BoxData[RowBox[{type, "[", "\"" <> "\[SelectionPlaceholder]" <> "\"", "]"}]], 
           "OpenEnvironment"], 
          Cell[BoxData[""], "FormalTextInputFormula", 
           CellTags -> {"ENV", "???"}],
          Cell[BoxData["\[GraySquare]"], "CloseEnvironment"]}];
    ]


(* ::Subsection:: *)
(* Buttons *)

envButtonData["DEFINITION"] := {"tcLangTabEnvTabButtonDefLabel"};
envButtonData["THEOREM"] := {"tcLangTabEnvTabButtonThmLabel"};

makeEnvButton[ bname_String] :=
    With[ { bd = envButtonData[bname]},
			Button[Style[ translate[bd[[1]]], "EnvButton"], insertNewEnv[bname], Appearance -> "FramedPalette", Alignment -> {Left, Top}]
    ]

allEnvironments = {"DEFINITION", "THEOREM", "LEMMA", "PROPOSITION", "COROLLARY", "CONJECTURE", "ALGORITHM"};
allEnvironments = {"DEFINITION", "THEOREM"};

envButtons[] := Pane[ Grid[ Partition[ Map[ makeEnvButton, allEnvironments], 2]]]

$buttonNat = False;

langButtonData["FORALL1"] := 
	{
		If[ $buttonNat, 
			translate["FORALL1"], 
			DisplayForm[RowBox[{UnderscriptBox["\[ForAll]", Placeholder["rg"]], TagBox[ FrameBox["expr"], "SelectionPlaceholder"]}]]],
		DisplayForm[RowBox[{UnderscriptBox["\[ForAll]", "\[Placeholder]"], "\[SelectionPlaceholder]"}]],
		translate["QUANT1Tooltip"]
	}

langButtonData["FORALL2"] := 
	{
		If[ $buttonNat, 
			translate["FORALL2"], 
			DisplayForm[RowBox[{UnderscriptBox[ UnderscriptBox["\[ForAll]", Placeholder["rg"]], Placeholder["cond"]], TagBox[ FrameBox["expr"], "SelectionPlaceholder"]}]]],
		DisplayForm[RowBox[{UnderscriptBox[ UnderscriptBox["\[ForAll]", "\[Placeholder]"], "\[Placeholder]"], "\[SelectionPlaceholder]"}]],
		translate["QUANT2Tooltip"]
	}

langButtonData["EXISTS1"] := 
	{
		If[ $buttonNat, 
			translate["EXISTS1"], 
			DisplayForm[RowBox[{UnderscriptBox["\[Exists]", Placeholder["rg"]], TagBox[ FrameBox["expr"], "SelectionPlaceholder"]}]]],
		DisplayForm[RowBox[{UnderscriptBox["\[Exists]", "\[Placeholder]"], "\[SelectionPlaceholder]"}]],
		translate["QUANT1Tooltip"]
	}

langButtonData["EXISTS2"] := 
	{
		If[ $buttonNat, 
			translate["EXISTS2"], 
			DisplayForm[RowBox[{UnderscriptBox[ UnderscriptBox["\[Exists]", Placeholder["rg"]], Placeholder["cond"]], TagBox[ FrameBox["expr"], "SelectionPlaceholder"]}]]],
		DisplayForm[RowBox[{UnderscriptBox[ UnderscriptBox["\[Exists]", "\[Placeholder]"], "\[Placeholder]"], "\[SelectionPlaceholder]"}]],
		translate["QUANT2Tooltip"]
	}

makeLangButton[ bname_String] :=
    With[ { bd = langButtonData[bname]},
			Tooltip[ PasteButton[ Style[ bd[[1]], "LangButton"], bd[[2]], Appearance -> "FramedPalette", Alignment -> {Left, Top}], bd[[3]], TooltipDelay -> 0.5]
    ]

allFormulae = {"FORALL1", "FORALL2", "EXISTS1", "EXISTS2"};

langButtons[] := Pane[ 
	Column[{
		Grid[ Partition[ Map[ makeLangButton, allFormulae], 2], Alignment -> {Left, Top}],
		Row[{translate["tcLangTabMathTabBS"], 
			Row[{RadioButton[Dynamic[$buttonNat], False], translate["tcLangTabMathTabBSform"]}, Spacer[2]], 
			Row[{RadioButton[Dynamic[$buttonNat], True], translate["tcLangTabMathTabBSnat"]}, Spacer[2]]}, Spacer[10]]
	}, Dividers -> Center, Spacings -> 4]]

(* ::Section:: *)
(* end of package *)

initGUI[];
  
End[] (* End Private Context *)

EndPackage[];
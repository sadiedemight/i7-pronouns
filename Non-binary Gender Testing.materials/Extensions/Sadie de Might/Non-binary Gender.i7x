Version 0.0.20230508 of Non-binary Gender by Sadie de Might begins here.

"To replace Inform's pronoun system with something less binarist."

Volume - Pronoun lexeme

A pronoun lexeme is a kind of value.
The specification of pronoun lexeme is "A combination of pronoun words which have a single meaning (and thus are a single lexical entry), but whose form varies by usage context (such as grammatical case). This only includes third person pronouns.".
Some pronoun lexemes are the implicit pronouns, they-them, she-her, he-him, the neuter pronouns, the plural pronouns, the plural animate pronouns.
[TODO: Consider making "the plural pronouns" animate and make explicit "the inanimate plural pronouns".]

A non-third-person pronoun lexeme is a kind of value.
The non-third-person pronoun lexemes are I-me, we-us, you-your singular, and you-your plural.

A personed pronoun lexeme is a kind of value.
The specification of personed pronoun lexeme is "A pronoun lexeme that is first, second, or third person.".
The personed pronoun lexemes are the unspeakable personed implicit pronouns.

To decide which personed pronoun lexeme is (P - a non-third-person pronoun lexeme) with person: (- (-({P})) -).
To decide which personed pronoun lexeme is (P - a pronoun lexeme) with person: (- ({P}) -).
Definition: a personed pronoun lexeme is third-person if I6 condition "(*1) >= 0" says so (it was made by adding person to a pronoun lexeme).
To decide which non-third-person pronoun lexeme is (P - a personed pronoun lexeme) as non-third-person: (- (-({P})) -).
To decide which pronoun lexeme is (P - a personed pronoun lexeme) as third-person: (- ({P}) -).
To say (P - a personed pronoun lexeme):
	if P is third-person, say P as third-person;
	otherwise say P as non-third-person.

Section - Understand some pronoun lexemes more briefly

Understand "implicit" as the implicit pronouns.
Understand "neuter" as the neuter pronouns.
Understand "plural" as the plural pronouns.

Part - Debugging

Use pronoun debugging of at least 0 translates as (-
#IfDef DEBUG;
Constant PRONOUN_DEBUG = {N};
#IfNot;
Constant PRONOUN_DEBUG = 0;
#EndIf;
-).

Part - Pronoun form

[TODO: It would make a lot more sense to actually make this all type-safe, but it would also be awfully nice to do most of this work in the imparative stage, before we get to I6 runtime, in which case everything about the types would change anyway.]

Include (-

! The type of a pronoun form varies from zero inclusive to PRONOUN_TYPE_RANGE excusive.
! A type of 0 must mean that the pronoun form is a dictionary word.
Constant PRONOUN_FORM_TYPE_RANGE = 2;

! Decides whether there's anything wrong with a pronoun form.
!   If this prints anything, it must start with the beginning of a sentence and end without punctuation or space.
!     The caller will follow up with a description of how the form was going to be used.
!   If there is a problem, this must print an explanation of the problem, beginning with "WARNING: ", and return false.
!   Otherwise, if PRONOUN_DEBUG < 5, this must return true without printing anything.
!   Otherwise, this must print a description of the form that was validated.
[ PronounValidate form type;
	#IfTrue PRONOUN_DEBUG >= 5;
	if (type) {
		print "Validated string ~", (string) form, "~";
	} else {
		print "Validated dictionary word ~", (address) form, "~";
	}
	#EndIf;
];

! Prints a pronoun form of the given type.
! When PRONOUN_DEBUG is positive, this may be called on a form that has not passed PronounValidate().
[ PronounSay form type;
	if (type) {
		print (string) form;
	} else {
		print (address) form;
	}
];

-).


Chapter - Built-in forms

To set the forms of (P - a pronoun lexeme): do nothing.

Include (-

[ PronounSetBuiltinForms;
	PronounSetForms((+ the implicit pronouns +), 'they?', "them?", 'their?', (+ third person singular +) + (+ third person plural +)*PRONOUN_VIEWPOINT + PronounFormTypes(0, 1), 'theirs?');
	PronounSetForms((+ they-them +), 'they', 'them', 'their', (+ third person singular +) + (+ third person plural +)*PRONOUN_VIEWPOINT);
	PronounSetForms((+ she-her +), 'she', 'her', 'her');
	PronounSetForms((+ he-him +), 'he', 'him', 'his', PRONOUN_THEIRS_IS_THEIR);
	PronounSetForms((+ the neuter pronouns +), 'it', 'it', 'its', PRONOUN_THEIRS_IS_THEIR + PRONOUN_INANIMATE, 'that');
	PronounSetForms((+ the plural pronouns +), 'they', 'them', 'their', PRONOUN_PLURAL + PRONOUN_INANIMATE, 'those');
	PronounSetForms((+ the plural animate pronouns +), 'they', 'them', 'their', PRONOUN_PLURAL);
	PronounSetForms(-(+ I-me +), "I", 'me', 'my', (+ first person singular +) + PronounFormTypes(1), 'mine');
	PronounSetForms(-(+ we-us +), 'we', 'us', 'our', PRONOUN_PLURAL + (+ first person plural +));
	PronounSetForms(-(+ you-your singular +), 'you', 'you', 'your', (+ second person singular +));
	PronounSetForms(-(+ you-your plural +), 'you', 'you', 'your', PRONOUN_PLURAL + (+ second person plural +));  ! Must be last.
];

-).

Part - Representation

Chapter - Saying

To say the/-- they of (P - a personed pronoun lexeme): (- PronounSayThey({P}); -).
To say the/-- them of (P - a personed pronoun lexeme): (- PronounSayThem({P}); -).
To say the/-- their of (P - a personed pronoun lexeme): (- PronounSayTheir({P}); -).
To say the/-- theirs of (P - a personed pronoun lexeme): (- PronounSayTheirs({P}); -).
To say the/-- themselves of (P - a personed pronoun lexeme): (- PronounSayThemselves({P}); -).
To say the/-- nominative those of (P - a personed pronoun lexeme): (- PronounSayThoseAre({P}); -).
To say the/-- accusative those of (P - a personed pronoun lexeme): (- PronounSayToThose({P}); -).

To decide which text is the/-- they of (P - a personed pronoun lexeme): decide on "[they of P]".
To decide which text is the/-- them of (P - a personed pronoun lexeme): decide on "[them of P]".
To decide which text is the/-- their of (P - a personed pronoun lexeme): decide on "[their of P]".
To decide which text is the/-- theirs of (P - a personed pronoun lexeme): decide on "[theirs of P]".
To decide which text is the/-- themselves of (P - a personed pronoun lexeme): decide on "[themselves of P]".
To decide which text is the/-- nominative those of (P - a personed pronoun lexeme): decide on "[nominative those of P]".
To decide which text is the/-- accusative those of (P - a personed pronoun lexeme): decide on "[accusative those of P]".

To decide which narrative viewpoint is the/-- viewpoint of referents of (P - a personed pronoun lexeme): (- PronounReferentVP({P}) -).
To decide which narrative viewpoint is the/-- viewpoint of verbs agreeing with (P - a personed pronoun lexeme): (- PronounVerbVP({P}) -).
Definition: a pronoun lexeme is semantically plural rather than semantically singular if I6 routine "PronounIsSemanticallyPlural" says so (its referent viewpoint is plural).

Include (-

[ PronounSayThey p;
	p = PronounRow(p);
	PronounSay(p-->0, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
];

[ PronounSayThem p;
	p = PronounRow(p);
	PronounSay(p-->1, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
];

[ PronounSayTheir p;
	p = PronounRow(p);
	PronounSay(p-->2, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
];

[ PronounSayTheirs p;
	p = PronounRow(p);
	if ((p-->4/PRONOUN_THEIRS_IS_THEIR)&1) {
		PronounSay(p-->2, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
	} else if (p-->3 == 0 || (p-->4/PRONOUN_INANIMATE)&1) {
		PronounSay(p-->2, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
		print (char) 's';
	} else {
		PronounSay(p-->3, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
	}
];

[ PronounSayThemselves p;
	p = PronounRow(p);
	switch ((p-->4)%PRONOUN_VIEWPOINT) {
		(+ first person singular +), (+ second person singular +):
			PronounSay(p-->2, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
			print "self";
		(+ third person singular +):
			PronounSay(p-->1, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
			print "self";
		(+ first person plural +), (+ second person plural +):
			PronounSay(p-->2, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
			print "selves";
		(+ third person plural +):
			PronounSay(p-->1, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
			print "selves";
	}
];

[ PronounSayThoseAre p;
	p = PronounRow(p);
	if ((p-->4/PRONOUN_INANIMATE)&1) {
		PronounSay(p-->3, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
	} else {
		PronounSay(p-->0, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
	}
];
[ PronounSayToThose p;
	p = PronounRow(p);
	if ((p-->4/PRONOUN_INANIMATE)&1) {
		PronounSay(p-->3, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
	} else {
		PronounSay(p-->1, p-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE);
	}
];

[ PronounIsSemanticallyPlural p;
	return (((PronounRow(p)-->4)/PRONOUN_PLURAL)&1) ~= 0;
];

[ PronounReferentVP p;
	return (PronounRow(p)-->4)%PRONOUN_VIEWPOINT;
];
[ PronounVerbVP p;
	return ((PronounRow(p)-->4)/PRONOUN_VIEWPOINT)%PRONOUN_VIEWPOINT;
];
[ PronounVPVaries p;
	return ((PronounRow(p)-->4)%(PRONOUN_VIEWPOINT*PRONOUN_VIEWPOINT))%(PRONOUN_VIEWPOINT+1) ~= 0;
];

[ PronounGNA p;
	return (PronounRow(p)-->4)/(PRONOUN_PLURAL/3)%12;
];

-).

Chapter - Storage

When play begins (this is the initialise pronouns rule):
	repeat with P running through pronoun lexemes:
		set the forms of P;
	initialise pronouns up to the last value of pronoun lexemes.
To initialise pronouns up to (P - a pronoun lexeme): (- PronounInitialise({P}); -).

Use pronoun form space of at least 7 translates as (- Constant PRONOUN_FORM_SPACE = {N}; -).
Use pronoun referent space of at least 4 translates as (- Constant PRONOUN_REFERENT_SPACE = {N}; -).
Use pronoun descriptor space of at least 16 translates as (- Constant PRONOUN_DESCRIPTOR_SPACE = {N}; -).

Include (-

Constant PRONOUN_VIEWPOINT             = 7;
Constant PRONOUN_THEIRS_IS_THEIR       = 7*7;
Constant PRONOUN_PLURAL                = 7*7*2*3;
Constant PRONOUN_INANIMATE             = 7*7*2*3*2;
Constant PRONOUN_RESET_FORMS           = 7*7*2*3*2*2*PRONOUN_FORM_TYPE_RANGE*PRONOUN_FORM_TYPE_RANGE*PRONOUN_FORM_TYPE_RANGE*PRONOUN_FORM_TYPE_RANGE;

! An array of 5 columns per row, where each row describes the forms of a pronoun lexeme, starting at index zero for (+ the implicit pronouns +).
! Column 0: The "they" form.
! Column 1: The "them" form.  This form may participate in parsing.
! Column 2: The "their" form.  This form may participate in parsing.
! Column 3: Either zero or the "theirs" form of the lexeme, if it denotes persons, or "those" form, otherwise, as a dictionary word.
! Column 4: This is several integer fields combined in radix notation:
!   That is, each field is within some small range from zero to one less than some max M.
!   A field is extracted by dividing the column value by P, the product of Ms for previous fields and taking the result modulo M for the field.
!     The next two fields are of type story viewpoints in I7, specifying the agreeing forms of verbs. 0 is unused.
!     M=7, P=1:
!       Viewpoint of verbs agreeing with referents of the pronoun lexeme.
!     M=7, P=(7)=PRONOUN_VIEWPOINT:
!       Viewpoint of verbs agreeing with the pronoun lexeme.  This differs from the previous field in the case of "they-them".
!     M=2, P=(7*7)=PRONOUN_THEIRS_IS_THEIR:
!       Whether the "theirs" form is the same as the "their" form, 0 if not, PRONOUN_THEIRS_IS_THEIR/P if so.
!     Note that the next 3 fields together are the same format as returned by GetGNAOfObject(). 
!     M=3, P=(7*7*2):
!       Grammatical gender: meaningless in English, always 0.
!     M=2, P=(7*7*2*3)=PRONOUN_PLURAL:
!       Semantic number: 0 if singular, PRONOUN_PLURAL/P if plural.
!     M=2, P=(7*7*2*3*2)=PRONOUN_INANIMATE:
!       Animacy: 0 if animate, denoting persons, or PRONOUN_INANIMATE/P if inanimate, denoting non-persons.
!     The next four fields all have M=PRONOUN_FORM_TYPE_RANGE; PRONOUN_FORM_TYPE_RANGE is appreviated as R here.
!     M=R, P=(7*7*2*3*2*2):
!       The type of the "they" form.
!     M=R, P=(7*7*2*3*2*2*R):
!       The type of the "them" form.
!     M=R, P=(7*7*2*3*2*2*R*R):
!       The type of the "their" form.
!     M=R, P=(7*7*2*3*2*2*R*R*R):
!       The type of the form stored in column 4, or zero if that is zero.
!     M=1+PRONOUN_REFERENT_SPACE*3, P=(7*7*2*3*2*2*R*R*R*R)=PRONOUN_RESET_FORMS:
!       Index into PronounReferents of the current referent of this lexeme, or 0 for a lexeme that cannot be parsed.
! In columns that store a form, a corresponding type is stored in colums 4.
!   If the type is 0, the form must be a dictionary word, such as `'they'`.
!     This form must be lower case and is limeted to a very short length (whose details depend on the virtual machine).
!     This form can participate in parsing.
!   The meaning of any other type is determined by PronounSay(), which must print all forms, including forms of type 0.
!     The additional forms exist primarily to support the pronoun form "I", which must be capitalized.
!     These form cannot be parsed, and thus if this form is used as either the "their" or "them" form of a lexeme, that lexeme does not participate in parsing.
!     The range of possible form types can be changed by a user that replaces PronouSay(), PronounValidate(), and the constant PRONOUN_FORM_TYPE_RANGE.
!     This extension's definitions of these only provide one other type, 1, which indicates that the form is a string.
Array PronounForms --> ((PRONOUN_FORM_SPACE+4)*5);

! Returns the address of the row of the PronounForms array that is for a given pronoun lexeme.
! If the lexeme is too large to have forms in the array, instead the row of the implicit pronouns is returned.
[ PronounRow p;
	if (p > PRONOUN_FORM_SPACE || p < -(+ you-your plural +)) p = (+ the implicit pronouns +);
	if (p < 0) return PronounForms + (+ you-your plural +)*5*WORDSIZE + p*5*WORDSIZE;
	return PronounForms + ((+ you-your plural +) - (+ I-me +))*5*WORDSIZE + p*5*WORDSIZE;
];

[ PronounFormIsInvalid is_valid p form_name they they_type them them_type;
	#IfTrue PRONOUN_DEBUG < 5;
	if (is_valid) return false;
	#EndIf;
	print " given as ~", (address) form_name, "~ form of pronoun lexeme ", p;
	if (them) {
		print " (";
		PronounSay(they, they_type);
		print "-";
		PronounSay(them, them_type);
		print ")";
	} else if (they) {
		print " (with ~they~ form ";
		PronounSay(they, they_type);
		print ")";
	}
	print ".^";
	#IfFalse PRONOUN_DEBUG < 5;
	if (is_valid) return false;
	#EndIf;
	return true;
];

[ PronounFormTypes they them their explicit  m option;
	m = PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE;
	option = option + explicit*m;
	m = m/PRONOUN_FORM_TYPE_RANGE;
	option = option + their*m;
	m = m/PRONOUN_FORM_TYPE_RANGE;
	option = option + them*m;
	m = m/PRONOUN_FORM_TYPE_RANGE;
	option = option + they*m;
	return option;
];

! Stores the pronoun forms of a pronous lexeme `p`.
!
! The "they", "them", and "their" forms are given directly, optionally followed by the sum of zero or more options, optionally followed by an additional form.
!
! The options can include PRONOUN_THEIRS_IS_THEIR, in which case the additional form, if given, is the "those" form, and the "theirs" form consists of the "their" form followed by 's'.
! The options can include PRONOUN_PLURAL; if present, the lexeme denotes plural referents, singular otherwise.
! The options can include PRONOUN_INANIMATE.
!   If given, the additional form most be given and is the "those" form of the lexeme.
!   If not given, the additional form may be given and if not zero, it is the "theirs" form.
!   If the "theirs" form is not given, it is determined by the presense or absense of PRONOUN_THEIRS_IS_THEIR.
! The options can include a narrative viewpoint of verbs agreeing with referents of the lexeme; if not given, third person, singular or plural according o the presense of PRONOUN_PLURAL, is used.
! The options can include a narrative viewpoint of verbs agreeing with the lexeme itself, multiplied by PRONOUN_VIEWPOINT; if not given, the viewpoint for referents is used.
! The options can include either PRONOUN_RESET_FORMS.
[ PronounSetForms p they them their options explicit  r they_type them_type explicit_type;
	if (p == 0 | p < -(+ you-your plural +)) {
		print "WARNING: ", p, " is not a pronoun lexeme.^";
		return;
	}
	if (p > PRONOUN_FORM_SPACE) return;  ! Don't complain; we do so just once before play begins.
	r = PronounRow(p);
	if (PronounForms-->0) {
		print "WARNING: Cannot set forms of pronoun lexeme ", p, " (", (PronounSayThey) p, "-", (PronounSayThem) p, ") after play begins.^";  ! TODO name the rule that runs PronounInitialise().
		return;
	}
	they_type = options/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE;
	if (PronounFormIsInvalid(PronounValidate(they, they_type), p, 'they')) return;
	them_type = options/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE;
	if (PronounFormIsInvalid(PronounValidate(them, them_type), p, 'them', they, they_type)) return;
	if (PronounFormIsInvalid(PronounValidate(their, options/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE), p, 'their', they, they_type, them, them_type)) return;
	explicit_type = options/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE;
	if ((options/PRONOUN_INANIMATE)&1) {
		if (explicit == 0) {
			print "WARNING: Must set ~those~ form of inanimate pronoun lexeme ", p, " (", (PronounSay) they, "-", (PronounSay) them, ").^";
			return;
		}
		if (PronounFormIsInvalid(PronounValidate(explicit, explicit_type), p, 'those', they, they_type, them, them_type)) return;
	} else if (explicit) {
		if ((options/PRONOUN_THEIRS_IS_THEIR)&1) {
			print "WARNING: Cannot combine PRONOUN_THEIRS_IS_THEIR with explicit ~theirs~ form of pronoun lexeme ", p, " (", (PronounSay) they, "-", (PronounSay) them, ").^";
			return;
		}
		if (PronounFormIsInvalid(PronounValidate(explicit, explicit_type), p, 'theirs', they, they_type, them, them_type)) return;
	} else if (explicit_type ~= 0) {
		print "WARNING: Cannot set type of form with out a form";
		PronounFormIsInvalid(false, p, 'theirs', they, they_type, them, them_type);
		return;
	}
	if (options/PRONOUN_RESET_FORMS > 1 || options%PRONOUN_PLURAL/PRONOUN_THEIRS_IS_THEIR > 1) {
		print "WARNING: Invalid options (", options, ") given for pronoun lexeme ", p, " (", (PronounSay) they, "-", (PronounSay) them, ").^";
		return;
	}
	if (r-->0) {
		print "WARNING: Cannot re-set forms of pronoun lexeme ", p, " (", (PronounSayThey) p, "-", (PronounSayThem) p, "), which is already set to ", (PronounSay) r-->0, "-", (PronounSay) r-->1, ".^";
		return;
	}
	if (options%PRONOUN_VIEWPOINT == 0) {
		if ((options/PRONOUN_PLURAL)&1) {
			options = options + (+ third person plural +);
		} else {
			options = options + (+ third person singular +);
		}
	}
	if (((options/PRONOUN_VIEWPOINT)%PRONOUN_VIEWPOINT) == 0) options = options + (options%PRONOUN_VIEWPOINT)*PRONOUN_VIEWPOINT;
	r-->0 = they;
	r-->1 = them;
	r-->2 = their;
	r-->3 = explicit;
	r-->4 = options;
	#IfTrue PRONOUN_DEBUG >= 4;
	print "Forms set for pronoun lexeme ", p, " (", (PronounSayThey) p, "-", (PronounSayThem) p, "-", (PronounSayTheir) p, "-", (PronounSayTheirs) p, "-", (PronounSayThemselves) p;
	if (PronounGNA(p) >= 6) print "-", (PronounSayThoseAre) p;
	if (PronounRow(p)-->4 >= PRONOUN_RESET_FORMS) print ", superceding previous parsable forms";
	print ") with referent viewpoint ", PronounReferentVP(p);
	if (PronounVPVaries(p)) print " but verb veiwpoint ", PronounVerbVP(p); 
	print " and GNA ", PronounGNA(p), ".^";
	#endif;
];

! A table of 3 columns per row, where each row describes the most recent referent of the "them" form of a third-person pronoun lexeme.
! This table matches the behavior of the standard kits' LanguagePronouns table.
!   Column 1: The "them" form, as a dictionary word.
!   Column 2: A bitmask of applicable GNA values.
!     If this extensions definition of PronounNotice() is used, this column is unused.
!     For each possible value returned by GetGNAOfObject(), the corresponding element in the array PowersOfTwo_TB has one bit set.
!     This bitmask thus selecets a set of possible results from GetGNAOfObject().
!     The standard kits' PronounNotice() updates this row if GetGNAOfObject() returns a selected value.
!   Column 3: NULL or the object that the "them" form currently refers to. 
!     PronounValue() returns the value in this column, given the corresponding form in column 1, or zero if no row matches.
Array PronounReferents --> (1+PRONOUN_REFERENT_SPACE*3);

! A table of 4 columns per row, where each row describes a descriptor word that the parser uses to help resolve what noun or nouns the player means.
! This table patches the behavior of the standard kits' LanguageDescriptors table.
!   Column 1: the descriptor, as a dictionary word; this may be the "their" form of a third person pronoun lexeme.
!   Column 2: A bitmask of applicable GNA values.
!     This has the same format as Column 2 in PronounReferents.
!     This bitmask selects only possible values of GetGNAOfObject() for objects are compatible with the descriptor in this row.
!   Column 3: The type of this descriptor.
!     Types DEFART_PK and INDEFART_PK indicate that the descriptor is an article; these can be parsed by ArticleDescriptors().
!     Rows with other types are parsed by Descriptors().
!       Types LIGHTED_PK and UNLIGHTED_PK select objects that are lit or unlit.
!       The type POSSESS_PK selects the object that PronounValue() returns for the value of column 4. 
!   Column 4: The "them" form of pronoun lexeme whose "their" form is in column 1.
!     This is 0 if the type in column 3 is not POSSESS_PK or if column 1 is a form of a first person pronoun lexeme.
!     This is 1 if column 1 is a proximal demonstrative ("this").
!     Otherwise, this is the "them" form corresponding to the "their" form in column 1.
Array PronounDescriptors --> (1+PRONOUN_DESCRIPTOR_SPACE*4);

[ PronounInitialise max  p p_row r k;
	if (PronounForms-->0) {
		print "WARNING: Pronoun lexemes must be initialized exactly once, and this is done by the Non-binary Gender extension itself; do not use the PronounInitialise routine or the ~initialise pronouns up to ...~ phrase.^";
		return;
	}
	PronounSetBuiltinForms();
	if (max > PRONOUN_FORM_SPACE) {
		print "WARNING: Must use pronoun form space of at least ", (max + 1);
		max = PRONOUN_FORM_SPACE;
		print "; all pronoun lexemes after ", max;
		p = PronounRow(max);
		if (p-->0) print " (", (PronounSay) p-->0, "-", (PronounSay) p-->1, ")";
		print " will be ignored.^";
	}
	#IfTrue PRONOUN_DEBUG > 0;
	if (PRONOUN_FORM_SPACE > max) {
		print "WARNING: No need to use pronoun form space more than ", max, ".^";
	}
	#Endif;

	r = PronounReferents;
	for (p = (+ the implicit pronouns +), p_row = PronounRow(p), max = p_row + max*5*WORDSIZE : p_row < max : ++p, p_row = p_row+5*WORDSIZE) {
		if (p_row-->0 == 0) {
			print "WARNING: Pronoun lexemes ", p, " has not had its forms set.^";
			! The forms of the implicit pronouns already indicate something that shouldn't be visible but is; reuse those.
			p_row-->0 = PronounRow((+ the implicit pronouns +))-->0;
			p_row-->1 = PronounRow((+ the implicit pronouns +))-->1;
			p_row-->2 = PronounRow((+ the implicit pronouns +))-->2;
			p_row-->3 = PronounRow((+ the implicit pronouns +))-->3;
			p_row-->4 = PronounRow((+ the implicit pronouns +))-->4;
			continue;
		}
		if ((p_row-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE) || (p_row-->4%PRONOUN_VIEWPOINT%3)) continue;
		! We've got a parsable "them" form in third person.  Find whether we've seen it before.
		for (k = PronounReferents : : k = k+3*WORDSIZE) {
			if (k < r) {
				if (k-->1 ~= p_row-->1) continue;
				#IfTrue PRONOUN_DEBUG >= 4;
				print "Pronoun lexeme ", p, " will also parse ~", (PronounSayThem) p, "~ as referent stored at index ", (k - PronounReferents + 3), ".^";
				#EndIf;
				p_row-->4 = p_row-->4%PRONOUN_RESET_FORMS + PRONOUN_RESET_FORMS*(k - PronounReferents + 3);
			} else {
				! This is a new "them" form; see if a later lexeme supersedes this lexeme's use of this form.
				for (k = p_row+5*WORDSIZE : k < max : k = k+5*WORDSIZE) {
					if ((k-->4/PRONOUN_RESET_FORMS)%3) {
						#IfTrue PRONOUN_DEBUG >= 5;
						print "Pronoun lexeme ", p, " has parsable forms superceded by ", (k - PronounForms)/(5*WORDSIZE)+1, ".^";
						#EndIf;
						jump NextLexeme;
					}
				}
				! We want to parse this new "them" form; is there space?
				if (PronounReferents-->0 < 0)	jump NextLexeme;  ! We previously ran out of space and complained.
				k = (r - PronounReferents)/(3*WORDSIZE)+1;
				if (k > PRONOUN_REFERENT_SPACE) {
					print "WARNING: Must use pronoun referent space of at least ", k, ", or maybe even more.^";
					PronounReferents-->0 = -1;
					jump NextLexeme;
				}
				
				#IfTrue PRONOUN_DEBUG >= 4;
				print "Pronoun lexeme ", p, " will parse ~", (PronounSayThem) p, "~ as referent stored at index ", k*3, ".^";
				#EndIf;
				p_row-->4 = p_row-->4%PRONOUN_RESET_FORMS + PRONOUN_RESET_FORMS*k*3;
				
				k = r;
				r = r+3*WORDSIZE;
				k-->1 = p_row-->1;
				if (p_row-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE) {
					k-->3 = 0;  ! Unparsable "their".
				} else {
					k-->3 = p_row-->2;
				}
			}
			break;
		}
		! Merge this lexeme's GNA mask with the one so far.
		k-->2 = k-->2 | ($$111 * PowersOfTwo_TB-->(p_row-->4/(PRONOUN_PLURAL/3)%6+2));
		! If all the "their" forms for this "them" form match, keep that; otherwise, reset to zero.
		if (p_row-->4/(PRONOUN_RESET_FORMS/PRONOUN_FORM_TYPE_RANGE/PRONOUN_FORM_TYPE_RANGE)%PRONOUN_FORM_TYPE_RANGE) {
			! Treat all unparsable forms as equivalent.
			if (k-->3 ~= NULL && k-->3 ~= 0) {
				print "Pronoun lexeme ", p, " with referents parsable as ~", (address) k-->1, "~ has unparsable possessive ~", (PronounSayTheir) p, "~, which does not match previous parsable possessive ~", (address) k-->3, "~.^"; 
				k-->3 = NULL;
			}
		} else {
			if (k-->3 ~= NULL && k-->3 ~= p_row-->2) {
				print "Pronoun lexeme ", p, " with referents parsable as ~", (address) k-->1, "~ has parsable possessive ~", (address) p_row-->2, "~, which does not match previous ";
				if (k-->3 == 0) {
					print "unparsable possessive.^";
				} else {
					print "parsable possessive ~", (address) k-->3, "~.^";
				}
				k-->3 = NULL;
			}
		}
		.NextLexeme;
	}
	r = (r - PronounReferents)/WORDSIZE;
	#IfTrue PRONOUN_DEBUG > 0;
	k = r/3;
	if (k < PRONOUN_REFERENT_SPACE ) {
		print "WARNING: No need to use pronoun reference space more than ", k, ".^";
	}
	#Endif;
	PronounReferents-->0 = r;
	! Now, PronounReferents is a table ready to replace LanguagePronouns, except that its referent column instead currently holds "their" forms corresponding to the "them" forms.

	r = PronounDescriptors;
	r-->1 = 'my';
	r-->2 = $$111111111111;
	r-->3 = POSSESS_PK;
	r-->4 = 0;
	r = r+4*WORDSIZE;
	r-->1 = 'this';
	r-->2 = $$111111111111;
	r-->3 = POSSESS_PK;
	r-->4 = 0;
	r = r+4*WORDSIZE;
	r-->1 = 'these';
	r-->2 = $$000111000111;
	r-->3 = POSSESS_PK;
	r-->4 = 0;
	r = r+4*WORDSIZE;
	r-->1 = 'that';
	r-->2 = $$111111111111;
	r-->3 = POSSESS_PK;
	r-->4 = 1;
	r = r+4*WORDSIZE;
	r-->1 = 'those';
	r-->2 = $$000111000111;
	r-->3 = POSSESS_PK;
	r-->4 = 1;
	r = r+4*WORDSIZE;
	r-->1 = 'the';
	r-->2 = $$111111111111;
	r-->3 = DEFART_PK;
	r-->4 = NULL;
	r = r+4*WORDSIZE;
	r-->1 = 'a//';
	r-->2 = $$111000111000;
	r-->3 = INDEFART_PK;
	r-->4 = NULL;
	r = r+4*WORDSIZE;
	r-->1 = 'an';
	r-->2 = $$111000111000;
	r-->3 = INDEFART_PK;
	r-->4 = NULL;
	r = r+4*WORDSIZE;
	r-->1 = 'some';
	r-->2 = $$000111000111;
	r-->3 = INDEFART_PK;
	r-->4 = NULL;
	r = r+4*WORDSIZE;
	r-->1 = 'lit';
	r-->2 = $$111111111111;
	r-->3 = LIGHTED_PK;
	r-->4 = NULL;
	r = r+4*WORDSIZE;
	r-->1 = 'lighted';
	r-->2 = $$111111111111;
	r-->3 = LIGHTED_PK;
	r-->4 = NULL;
	r = r+4*WORDSIZE;
	r-->1 = 'unlit';
	r-->2 = $$111111111111;
	r-->3 = UNLIGHTED_PK;
	r-->4 = NULL;
	r = r+4*WORDSIZE;
	k = (r-PronounDescriptors)/(4*WORDSIZE);
	#IfTrue PRONOUN_DEBUG >= 5;
	print "Must use pronoun descriptor space of at least ", k, " for descriptors not from pronoun lexemes.^";
	#EndIf;
	for (p_row = PronounReferents+3*WORDSIZE, p = PronounReferents+PronounReferents-->0*WORDSIZE : p_row <= p : p_row = p_row+3*WORDSIZE) {
		if (p_row-->0 == 0 || p_row-->0 == NULL) continue;  ! Unparsable or clashing "their" form.
		if (k == PRONOUN_DESCRIPTOR_SPACE) {
			print "WARNING: Must use pronoun descriptor space of at least ", k+1, ", or maybe even more.^";
			break;
		}
		r-->1 = p_row-->0;
		r-->2 = $$111111111111;
		r-->3 = POSSESS_PK;
		r-->4 = p_row-->-2;
		r = r+4*WORDSIZE;
		++k;
		#IfTrue PRONOUN_DEBUG >= 4;
		print "Possessive ~", (address) p_row-->0, "~ will parse as pertaining to referrents of ~", (address) p_row-->-2, "~.^";
		#EndIf;
	}
	#IfTrue PRONOUN_DEBUG > 0;
	if (k < PRONOUN_DESCRIPTOR_SPACE) print "No need to use pronoun descriptor space more than ", k, ".^";
	#EndIf;
	PronounDescriptors-->0 = k*4;	
		
	PronounReset();
];

-).

Part - Pertinence

Chapter - Object pronouns

Section - Value as a pronoun lexeme

[This let's use use a value as an explicit pronoun lexeme if and only if it is an appropriate type.]
To decide which pronoun lexeme is (V - a value of kind K) as a pronoun lexeme: decide on the implicit pronouns.
To decide which pronoun lexeme is (P - a personed pronoun lexeme) as a pronoun lexeme:
	if P is third-person, decide on P as third-person;
	decide on the implicit pronouns.
To decide which pronoun lexeme is (P - a pronoun lexeme) as a pronoun lexeme: decide on P.

Section - Implied pronouns

Yourself has a pronoun lexeme called explicit pronouns.
The explicit pronouns property translates into I6 as "pronouns".

To decide whether (O - an object) provide/provides a/the/-- explicit pronouns property: (- (({O}) provides pronouns) -).

To decide which pronoun lexeme is the implied pronouns of (O - an object):
	if O is nothing, decide on the neuter pronouns;
	if O provides the explicit pronouns property:
		let P be explicit pronouns of O as a pronoun lexeme;
		unless P is the implicit pronouns, decide on P;
	if O is plural-named, decide on the plural pronouns;
	if O is neuter or O is not a person, decide on the neuter pronouns;
	if O is female, decide on she-her;
	decide on he-him.

Chapter - Rulebooks

Section - Appertaining

To apply (P - a personed pronoun lexeme based rule) to pertinent pronouns according to (R - a nothing based rule): (- PronounPertinence({P}, 0, {R}); -).
To apply (P - a personed pronoun lexeme based rule) to pertinent pronouns according to (R - a value of kind K based rule) for (V - a K): (- PronounPertinence({P}, 0, {R}, {V}); -).
To apply (P - a personed pronoun lexeme based rule producing a value) to pertinent pronouns according to (R - a nothing based rule): (- PronounPertinence({P}, {-strong-kind:K}, {R}); -).
To apply (P - a personed pronoun lexeme based rule producing a value) to pertinent pronouns according to (R - a value of kind K based rule) for (V - a K): (- PronounPertinence({P}, {-strong-kind:K}, {R}, {V}); -).
[To decide what K is the (name of kind K) produced by the rulebook: (- ResultOfRule(0, 0, 0, {-strong-kind:K}) -).]
To decide what K is the product of applying (P - a personed pronoun lexeme based rule producing a value of kind K) to pertinent pronouns according to (R - a nothing based rule): (- ResultOf(0, PronounPertinence({P}, 0, {R}), 0, {-strong-kind:K}) -).
To decide what K is the product of applying (P - a personed pronoun lexeme based rule producing a value of kind K) to pertinent pronouns according to (R - a value of kind L based rule) for (V - a L): (- ResultOfRule(0, PronounPertinence({P}, {-strong-kind:L}, {R}, {V}), 0, {-strong-kind:K}) -).

To (P - a pronoun lexeme) appertains/appertain: (- if (PronounAppertains({P})) rtrue; -) - in to only.
To (P - a non-third-person pronoun lexeme) appertains/appertain: (- if (PronounAppertains(-({P}))) rtrue; -) - in to only.
To (P - a personed pronoun lexeme) appertains/appertain: (- if (PronounAppertains({P})) rtrue; -) - in to only.

A pronoun number-animacy combination is a kind of value.
The pronoun number-animacy combinations are singular-animate, plural-animate, singular-inanimate, and plural-inanimate.

To decide whether any/some pronouns already appertain: (- (pronoun_pertinence_info_active ~= 0) -).
To decide whether any/some (C1 - a pronoun number-animacy combination) pronouns already appertain: (-
	(0 ~= (pronoun_pertinence_info_active &  IncreasingPowersOfTwo_TB-->(7+({C1}))  ))
-).
To decide whether any/some (C1 - a pronoun number-animacy combination) or
                           (C2 - a pronoun number-animacy combination) pronouns already appertain: (-
	(0 ~= (pronoun_pertinence_info_active & (IncreasingPowersOfTwo_TB-->(7+({C1}))
	                                        |IncreasingPowersOfTwo_TB-->(7+({C2})))))
-).
To decide whether any/some (C1 - a pronoun number-animacy combination) or
                           (C2 - a pronoun number-animacy combination) or
                           (C3 - a pronoun number-animacy combination) pronouns already appertain: (-
	(0 ~= (pronoun_pertinence_info_active & (IncreasingPowersOfTwo_TB-->(7+({C1}))
	                                        |IncreasingPowersOfTwo_TB-->(7+({C2}))
	                                        |IncreasingPowersOfTwo_TB-->(7+({C3}))))) -).
To decide whether (P - a non-third-person pronoun lexeme) already appertains: (-
	(0 ~= (pronoun_pertinence_info_active & IncreasingPowersOfTwo_TB-->(11+({P}))))
-).
To decide which number is the count of pronoun lexemes that already appertain: (- (pronoun_pertinence_info_active & 255) -).

The pertinent pronouns rules are a object based rulebook.

The elaborated pertinent pronouns rules are a object based rulebook.

Elaborated pertinent pronouns for an object (called O) (this is the try pertinent pronouns before elaborating rule):
	abide by the pertinent pronouns rules for O.

Elaborated pertinent pronouns for an object (called O) (this is the implied object pronouns appertain if needed rule):
	unless some pronouns already appertain, the implied pronouns of O appertain.

Elaborated pertinent pronouns for an object (called O) (this is the ambiguously plural object pronouns pertain by default rule):
	unless O is ambiguously plural, make no decision;
	unless some plural-animate or plural-inanimate pronouns already appertain, the plural pronouns appertain.

Include (-

Global pronoun_pertinence_rule;
Global pronoun_pertinence_kind;
Global pronoun_pertinence_info;
Global pronoun_pertinence_info_active;

[ PronounAppertains p  decided;
	if (FollowRulebook(pronoun_pertinence_rule, p, true)) decided = true;
	if (p < 0) {
		p = 11 - p;
	} else {
		p = 8 + PronounGNA(p)/3;
	}
	pronoun_pertinence_info_active = 1 + (pronoun_pertinence_info_active | IncreasingPowersOfTwo_TB-->p);
	return decided;
];

[ PronounPertinence rule kind rulebook parameter  old_rule old_kind old_info;
	old_rule = pronoun_pertinence_rule;
	old_kind = pronoun_pertinence_kind;
	! Note that the kind of "parameter" is not stored; it is assume that the rules within rulebook know that.
	old_info = pronoun_pertinence_info_active;
	pronoun_pertinence_rule = rule;
	pronoun_pertinence_kind = kind;
	pronoun_pertinence_info_active = 0;
	FollowRulebook(rulebook, parameter, true);
	(+ the implied object pronouns appertain if needed rule +)();
	pronoun_pertinence_info = pronoun_pertinence_info_active;
	pronoun_pertinence_rule = old_rule;
	pronoun_pertinence_kind = old_kind;
	pronoun_pertinence_info_active = old_info;
];

-).

[This rulebook is not used, but provides type information about rules that are put in it.]
The typed pronoun lexeme producing pronoun rules are a personed pronoun lexeme based rulebook producing a pronoun lexeme.
A typed pronoun lexeme producing pronoun rule for a third-person personed pronoun lexeme (called P) (this is the produce pronouns rule):
	the rule succeeds with result P as third-person.

Section - Referents

The pronouns pertinent to referents is an object based rulebook that varies. The pronouns pertinent to referents is usually the elaborated pertinent pronouns rules.

To decide which pronoun lexeme is the/-- pronouns of (O - an object): (- PronounOfObject({O}) -).

Include (-

[ PronounOfObject obj;
	PronounPertinence((+ the produce pronouns rule +), 0, (+ pronouns pertinent to referents +), obj);
	return latest_rule_result-->2;
];

-).


Part - Prior named

Use story viewpoint overrides player pronoun number translates as (-
Constant PRONOUN_USE_VIEWPOINT_NUMBER;
Global pronoun_viewpoint_number_forced = true;
[ PronounViewpointNumberForce force; pronoun_viewpoint_number_forced = force; ];
-).
Include (-
#IfNDef PRONOUN_USE_VIEWPOINT_NUMBER;
Constant pronoun_viewpoint_number_forced = false;
[ PronounViewpointNumberForce force; if (force) print "**^** Cannot enable player pronoun number override by story viewpoint when story viewpoint overrides player pronoun number option is not active.^**"; ];
#EndIf;
-).
To decide whether story viewpoint overrides player pronoun number: (- pronoun_viewpoint_number_forced -).
To set player pronoun number override by story viewpoint to (F - a truth state): (- PronounViewpointNumberForce({F}); -).

Use plural player forces plural pronouns translates as (- Constant PLURAL_PLAYER_FORCES_PLURAL; -).[the original forces *they*, not just any plural, such as we.]
Use neuter player forced binary pronouns translates as (- Constant NEUTER_PLAYER_FORCED_BINARY; -).
Use player forces nominative those translates as (- Constant PLAYER_FORCES_NOMINATIVE_THOSE; -).

To decide which personed pronoun lexeme is the prior pronouns needed, regarding player or with player viewpoint: (- PronounOfPN({phrase options}) -).
To decide which personed pronoun lexeme is the prior pronouns needed with later verbs adapted, regarding player: (- PronounOfPNSettingVP({phrase options}) -).

Include (-

! Option bits:
! 1: First changes the prior noun to the player. This implies the next option.
! 2: If PLURAL_PLAYER_FORCES_PLURAL, returns plural when needed.
! This examines prior_named_list to return plural as appropriate, and handles the current player specially, returning pronouns appropriate to story_viewpoint.
[ PronounOfPN opts  p;
	if (opts & 1) {
		RegardingSingleObject(player);
		p = PronounOfObject(prior_named_noun);
	} else if (prior_named_list >= 2) {
		return (+ plural pronouns +);
	} else {
		! Should: if (prior_named_noun == nothing && prior_named_list < -1) return (+ plural pronouns +);
		! Should(?): if (prior_named_noun == nothing && prior_named_list == 0) return (+ plural pronouns +);
		p = PronounOfObject(prior_named_noun);
		if (prior_named_noun ~= player) return p;
	}

	if (~~PronounIsSemanticallyPlural(p)) {
		! p is semantically singular.
		switch (story_viewpoint) {
			(+ first person singular +): return -(+ I-me +);
			(+ second person singular +): return -(+ you-your singular +);
			(+ first person plural +):
				if (pronoun_viewpoint_number_forced) return -(+ we-us +);
				return -(+ I-me +);
			(+ second person plural +):
				if (pronoun_viewpoint_number_forced) return -(+ you-your plural +);
				return -(+ you-your singular +);
			(+ third person plural +):
				if (pronoun_viewpoint_number_forced) return (+ the plural animate pronouns +);
				! Fall through to maybe replace neuter with gendered.
		}
		#ifdef NEUTER_PLAYER_FORCED_BINARY;
		if (p ~= (+ the neuter pronouns +)) return p;
		! Fall through to select he or she, overiding the player's pronouns because they are neuter.
		#ifnot;
		return p;
		#endif;
	} else {
		#IfDef PLURAL_PLAYER_FORCES_PLURAL;
		if (opts == 0 && pronoun_viewpoint_number_forced) return (+ plural pronouns +);
		#EndIf;
		switch (story_viewpoint) {
			(+ first person singular +):
				if (pronoun_viewpoint_number_forced)  return -(+ I-me +);
				return -(+ we-us +);
			(+ second person singular +):
				if (pronoun_viewpoint_number_forced) return -(+ you-your singular +);
				return -(+ you-your plural +);
			(+ third person singular +):
				if (~~pronoun_viewpoint_number_forced) return p;
				#ifNdef NEUTER_PLAYER_FORCED_BINARY;
				! We're overriding the player's plural pronouns because of the story viewpoint but if we're allowed to use neuter pronouns, so try those.
				if (player has neuter) return (+ the neuter pronouns +);
				#EndIf;
				! Fall through to select he or she, overiding the player's pronouns because they are plural.
			(+ first person plural +): return -(+ we-us +);
			(+ second person plural +): return -(+ you-your plural +);
			(+ third person plural +): return p;
		}
	}
	if (player has female) return (+ she-her +);
	return (+ he-him +);
];
[ PronounOfPNSettingVP opts  p q;
	p = PronounOfPN(opts);
	if (prior_named_list < 2 && prior_named_noun ~= nothing) {
		! prior_named_list is definitely 1, we can use its space to stash the VP as long as we encode it as <1.
		if (PronounVPVaries(p)) prior_named_list = -1; 
	}
	return p;
];

-).

Part - Utilities

Chapter - Clearing the pronouns

To clear pronouns: (- PronounReset(); -).
Clearing the pronouns is an action out of world.
Carry out clearing the pronouns: clear pronouns.
Report clearing the pronouns: say "Pronoun referents forgotten.".

Include (-

[ PronounReset  i;
	for (i=1 : i <= LanguagePronouns-->0 : i = i + 3) {
		LanguagePronouns-->(i+2) = NULL;
	}
];

-).

Section - Understand clearing the pronouns

Understand "pronouns reset" as clearing the pronouns.

Chapter - Requesting the pronouns

To demonstrate pronouns about (T - some text) calling them (P - some text):
	say "Considering [T], as for [those], [they] [have] as [their] pronouns [the prior pronouns needed, with player viewpoint]. [Those] [are] able to use such pronouns as [theirs] for [themselves]. [P] [adapt the verb are from third person plural] also for others to use on [them]".
To say The pronouns demo about (T - some text):
	demonstrate pronouns about "the pronouns of [T]" calling them "[Their] pronouns".	
To say The pronouns demo about (O - an object):
	demonstrate pronouns about "[the O]" calling them "[regarding O][Possessive] pronouns".

Requesting the personed pronouns of is an action out of world and applying to one object.
Report requesting the personed pronouns of: say "[The pronouns demo about the noun].".
Understand "pronouns of/-- [things]" as requesting the personed pronouns of.
The specification of the requesting the personed pronouns of action is "Says a silly sentence to show off all the pronoun forms of a thing.".

Chapter - Setting the pronouns

Setting the explicit pronouns of it to is an action out of world and applying to one thing and one pronoun lexeme.
Carry out setting the explicit pronouns of it to: now the explicit pronouns of the noun are the pronoun lexeme understood.
Report setting the explicit pronouns of: say "The explicit pronouns of [the noun] are now [if the explicit pronouns of the noun are the implicit pronouns]implicit, behaving as [end if][the implied pronouns of the noun][unless the pronouns of the noun are the implied pronouns of the noun], but other rules are making [their] pronouns [the pronouns of the noun][end if].".

Section - Understand as setting the explicit pronouns of it to (not for release)

Understand "set the/-- explicit/-- pronouns of/-- [something] to/-- [a pronoun lexeme]" as setting the explicit pronouns of it to.

Volume - English Language Replacements

To decide which narrative viewpoint is the prior naming context viewpoint: (- PNToVP() -).

Include (-
[ PNToVP  pers;
	if (prior_named_list >= 2) return 6;
	if (prior_named_noun == nothing) return 3;
	! Given a particular prior naming context, if there is one thing, it can change between being the player or not without being regarded, so we can't store VP on that basis.
	! But we can require that the user calls `say regarding the prior named noun` if they change its pronouns. (Give a phrase for this.)
	! So, we can use prior_named_list to store the third person pronouns, including storing different values depending on whether it is using referent viewpoint or verb viewpoint.
	! For now, we only use this to indicate verb viewpoint of plural-agreeing singular. (try storing singular and plural, too.)
	! Set pers to the amount by which to reduce the pronouns' viewpoint to get to the person of the wanted viewpoint.
	if (prior_named_noun ~= player) {
		pers = 0; ! Not the player, use the third person viewpoint of the pronouns.
	} else if (pronoun_viewpoint_number_forced) {
		if (prior_named_list < 0) return 6;  ! Not clear what's best to do here.
		return story_viewpoint;
	} else if (story_viewpoint > (+ third person singular +)) {
		pers = (+ third person plural +) - story_viewpoint;
	} else {
		pers = (+ third person singular +) - story_viewpoint;
	}
	if (prior_named_list < 0 && pers == 0) return PronounVerbVP(PronounOfObject(prior_named_noun));
	return PronounReferentVP(PronounOfObject(prior_named_noun)) - pers;
	! Original:  gna;
	! if (prior_named_noun == player) return story_viewpoint;
	! if (prior_named_noun) gna = GetGNAOfObject(prior_named_noun);
	! if (((gna%6)/3 == 1) || (prior_named_list >= 2)) return 6;
	! return 3;
];
-) replacing "PNToVP".

Include (-
! The GNA of an object encodes its "gender", number (singular or plural), and animacy (whether it's like a living thing).
! The "gender" is either 0, 1, or 2, corresponding to he-him, she-her, and it-it, respectively, but there is nothing that depends on this value.
! Number is 0 or 1, for singular or plural respectively; this is used several places.
! Animacy is 0 or 1, for animate or inanimate respectively; this matches the "animate" property, inverted, which is set true for all kinds of person.
! These are encoded together in radix notation, "gender" in the ones place, number in the threes place, and animacy in the sixes place.
!
! The result of this function is used:
!   To index into LanguageGNAsToArticles to select what article to print for an object.
!    In English, this uses number to select between "a" and "some" for indefinite articles.
!	  This assumes that (the GNA/3)%2 is the grammatical number.
!   When a list of objects are regarded or listed, and all have the same gender, that is stored in prior_named_list_gender.
!     But this is not used in English.
!   PronounNotice() populates elements in LanguagePronouns.
!     LanguagePronouns is an array of tuples (the third person pronoun word, mask of GNAs to which it applies, its current referent).
!     If the object is ambiguously plural, PronounNotice() also forces the GNA to plural and updates those pronoun referents.
!     LanguagePronouns is then consulted by PronounValue() when parsing a "them" form of a pronoun lexeme.
!     This assumes that (the GNA/3)%2 is the grammatical number.
!   Descriptors() parses descriptor words in LanguageDescriptors to help ScoreMatchL to match a noun phrase to an object.
!     ScoreMatchL uses the GNA as an index into PowersOfTwo_TB to select one bit in a mask of applicable GNAs.
!     LanguageDescriptors is an array with these columns:
!       Column 1: the descriptor word; this may be the "their" form of a pronoun lexeme.
!       Column 2: mask of GNAs to which it might apply
!       Column 3: descriptor type
!       Column 4: if the type is PROCESS_PK this is the "them" form corresponding to the "their" form
!     When the grammatical gender of a noun matches the grammaticl gender of a pronoun being parsed, that slightly improves the score for the noun.
!       ResetDescriptors() sets the mask that includes everything to just 12 bits of ones.
!     Some descriptor words are the "their" of a pronoun lexeme:
!       If the corresponding "them" form currently has a referent, only nouns associated with the referrent are selected.
!       If the "them" form has no current referent, the "their" form is treated like "a/an".
!   To select number in PNToVP, but this is overridden with this extension.
[ GetGNAOfObject obj  g;
	return PronounGNA(PronounOfObject(obj));
	!	Original: obj  case gender;
	!	if (obj hasnt animate) case = 6;
	!	if (obj has male) gender = male;
	!	if (obj has female) gender = female;
	!	if (obj has neuter) gender = neuter;
	!	if (gender == 0) {
	!		if (case == 0) gender = LanguageAnimateGender;
	!		else gender = LanguageInanimateGender;
	!	}
	!	if (gender == female)   case = case + 1;
	!	if (gender == neuter)   case = case + 2;
	!	if (obj has pluralname) case = case + 3;
	!	return case;
];
-) replacing "GetGNAOfObject".

Include (-
! Original GetGender person;
!   if (person hasnt female) rtrue;
!   rfalse;
! ];
-) replacing "GetGender".

Include (-
Global pronoun_pertinence_parameter;
[ PRONOUN_REFERS_TO_OBJECT_R  p;
	if (parameter_value >= 0) {
		p = PronounRow(parameter_value)-->4/PRONOUN_RESET_FORMS;
		if (p > 0) LanguagePronouns-->p = pronoun_pertinence_parameter;
	}
	rfalse;
];
[ PronounNotice obj  old_parameter;
	if (obj == player) return;
	old_parameter = pronoun_pertinence_parameter;
	pronoun_pertinence_parameter = obj;
	PronounPertinence(PRONOUN_REFERS_TO_OBJECT_R, 0, (+ pronouns pertinent to referents +), obj);
	pronoun_pertinence_parameter = old_parameter;
	! Original: obj  x bm g;
	! if (obj == player) return;
	! g = (GetGNAOfObject(obj));
  ! bm = PowersOfTwo_TB-->g;
	! for (x=1 : x<=LanguagePronouns-->0 : x=x+3)
	! 	if (bm & (LanguagePronouns-->(x+1)) ~= 0)
	! 		LanguagePronouns-->(x+2) = obj;
	! if (((g % 6) < 3) && (obj has ambigpluralname)) {
	! 	g = g + 3;
	! 	bm = PowersOfTwo_TB-->g;
	! 	for (x=1 : x<=LanguagePronouns-->0 : x=x+3)
	! 		if (bm & (LanguagePronouns-->(x+1)) ~= 0)
	! 			LanguagePronouns-->(x+2) = obj;
	! }
];
-) replacing "PronounNotice".

Include (-
Constant LanguagePronouns = PronounReferents;
-) replacing "LanguagePronouns".

Include (-
Constant LanguageDescriptors = PronounDescriptors;
-) replacing "LanguageDescriptors".

Section 1 - Grammatical definitions

[This section is not replaced.]

Section 2 - Saying pronouns (in place of Section 2 - Saying pronouns in English Language by Graham Nelson)

To decide which personed pronoun lexeme is the pronouns regarding the player:
	decide on (the prior pronouns needed, regarding player).
To say we: say they of (the prior pronouns needed with later verbs adapted, regarding player).
To say us: say them of the pronouns regarding the player.
To say our: say their of the pronouns regarding the player.
To say ours: say theirs of the pronouns regarding the player.
To say ourselves: say themselves of the pronouns regarding the player.

To say We: say "[we]" in sentence case.
To say Us: say "[us]" in sentence case.
To say Our: say "[our]" in sentence case.
To say Ours: say "[ours]" in sentence case.
To say Ourselves: say "[ourselves]" in sentence case.

Section 3 - Further pronouns (in place of Section 3 - Further pronouns in English Language by Graham Nelson)

To say those: say those in the accusative.
To say those in (C - grammatical case):
	if C is nominative:
		say the nominative those of (the prior pronouns needed, adapting future verbs);
	otherwise if the noun is the player and the player forces nominative those option is active:
		say the nominative those of the prior pronouns needed;
	otherwise:
		say the accusative those of the prior pronouns needed.

To say they: say they of the prior pronouns needed with later verbs adapted.
To say them: say them of the prior pronouns needed.
To say their: say their of the prior pronouns needed.
To say theirs: say theirs of the prior pronouns needed.
To say themselves: say themselves of the prior pronouns needed.

To say they're: say "[if the prior naming context is plural][they][else][those in nominative][end if]['re]".

To say Those in (case - grammatical case): say "[those in case]" in sentence case.
To say Those: say Those in the nominative.
To say They: say "[they]" in sentence case.
To say Their: say "[their]" in sentence case.
To say Them: say "[them]" in sentence case.
To say Theirs: say "[theirs]" in sentence case.
To say Themselves: say "[themselves]" in sentence case.
To say They're: say "[they're]" in sentence case.

To say possessive:
	let O be the prior named object;
	[You'd think this could be "[their]" since O is already the player, but there are some other subtle differences in the original behavior.]
	if O is the player, say "[our]";
	otherwise say "[the O][apostrophe][if the pronouns of O are semantically singular]s[end if]".
To say Possessive:
	[Since "[possessive]" can produce more than one word for non-player objects, applying `in sentence case` can downcase things we don't want changed.]
	let O be the prior named object;
	if O is the player, say "[Our]";
	otherwise say "[The O][apostrophe][if the pronouns of O are semantically singular]s[end if]".

To say it: say "[regarding nothing]it".
To say it's: say "[regarding nothing]it['re]".
To say there: say "[regarding nothing]there".
To say It's: say "[regarding nothing]It['re]".
To say there's: say "[regarding nothing]there['re]".
To say It: say "[regarding nothing]It".
To say There: say "[regarding nothing]There".
To say There's: say "[regarding nothing]There['re]".

Non-binary Gender ends here.

---- DOCUMENTATION ----

Chapter: Philosophy

Pronouns, at least in English, muddle together several separate ideas. This extension aims to provide some better tools for disentangling them.

Pronouns vary in several ways:

	(1) Different sorts of things must be refered to by different pronouns.

	(1-a) Number. A pronoun is either sigular or plural, referring to either one or more than one thing. ("She has a dog." vs "They have a dog.")

	(1-b) Animacy. A pronoun is either animate or inanimate, referring to either a person (or at least person-like thing), or a non-person thing. ("Who fell over?" vs "What fell over?")

	(1-c) Personal gender. A pronoun may indicate what gender the speaker thinks a person has. ("She's here." vs "He's here.")

	(2) Grammatical person. Refering to a particular thing can require different pronouns depending on the speaker's perspective. ("Adam, I love you." vs "Steve, you love me.")

	(3) The specific form of a pronoun depends on the syntax it's used with, and differences in form add no information.

	(3-a) A pronoun and verb must agree in form.  ("I am." vs "You are." vs "She is.", but never "They is.")

	(3-b) A pronoun and its syntactic context must agree in form. ("I have a book." vs "Somebody gave me a book." vs "My book is here." vs "The book is mine.", but never "The book is my.")

Many languages would add a (3-c), grammatical gender, to this list, where the language has a small set of groups, each called a gender, into which all nouns are distributed, requiring agreement between a pronoun and the gender of the noun it refers to. For example, in German, "dein mädchen" (meaning "your girl") is of the neuter gender, while "deine rübe" ("your turnip") is of the feminine gender, as is "deine schwester" ("your sister"), who may well simultaneously be somebody's (neuter) girl. But English does not really have more than one gender in this sense, except to the extent that animacy can be viewed as a gender system.

Since the variations in (3) do not carry any information about a thing or a situation, only depending on the information about surrounding words, we can bundle together all the pronouns that fit a particular thing and situation, calling them all "forms" of the same "lexeme".  This extension provides a new kind of value called a "personed pronoun lexeme", and its various "pronoun forms" can be fetched for use in various syntactic contexts.

Each personed pronoun lexeme also has properties of number (1-a), animacy (1-b), and grammatical person (2).  This leaves the identity of the lexeme itself to indicate personal gender (1-c). For example, there are both a he-him and a she-her lexeme, which have the same number (singular), animacy (animate), and person (third). This extension provides several built-in personed pronoun lexemes.

Section: First and second person

As Section 14.1 of "Writing with Inform" explains, interactive fiction is unusual in that it often speaks to the player directly, with the game talking to the player in the second person ("You can't go that way."). This extension therefore provides lexemes for second person pronouns for use in talking to the player.  It also provides lexemes for first person pronouns in case the story viewpoint is changed to first person.

Together, these are another kind of value, a subset of the personed pronoun lexemes, called the "non-third-person pronoun lexemes". Don't worry too much about how cumbersome this name is, you shouldn't need it much. 

Similarly, third person pronoun lexemes are used if the story viewpoint is changed to third person, but third person lexemes are also used to talk about things within the simulated game world, regardless of story viewpoint.

Section: Third person

Much of the time pronouns are used to talk about things in the third person, and within traditional English pronouns, only in the third person ones differ for people with different gender identies.  Thus, this extension uses third person pronouns as a property of things to describe their number, animacy, and personal gender. (But not their grammatical number; that is not a property.) These lexemes are another kind of value, just called "pronoun lexemes".

This extension does provide several lexemes of this kind, but a user of this extension can also add more lexemes.

Most of the built-in pronoun lexemes are used to capture the behavior of Inform without this extension.  For instance, when a non-person object with no pronoun lexeme property at all is talked about, the lexeme with the forms "it", "its", and "itself" is used.

Section: Singular they

This extension does provide one new pronoun lexeme that has no previous equivalent in Inform, the "they-them" pronoun lexeme.

This lexeme is singular in number, and it has a form "themself", not "themselves". 

This differs from the "she-her" and "he-him" lexemes in that it does not indicate either a masculine or feminine personal gender.

This differs from the "plural pronouns" lexeme in that it refers to something with singular number, but when verb forms must agree with this lexeme, the verbs use the form associated with plural. For example, in "Chris is here. They are clearly agitated.", a person using simgular "they" first agrees with the singular form of the verb to be, "is", and then the pronoun about that same person then agrees with the plural form of the verb, "are".

Chapter: Usage

Further details of how to use this extension are provided within examples below.

Example: * Intro - A basic use of the extension.

In the simplest case, just include this extension and create rules specifying which pronouns pertain to what.  Note that one thing can be referred to by more than one pronoun lexeme.

And the pronouns that are currently applicable to a thing can be demonstrated by printing an inane sentence about the thing, using all the forms of its pronoun lexeme, from the current story viewpoint.

	*: "Intro"

	Include Non-binary Gender by Sadie de Might.
	The Warf is a room.  There is a supporter called The Pequod. It is in the Warf. Ahab is a man on the Pequod.
	Pertinent pronouns for the Pequod: she-her appertains; neuter pronouns appertain.
	
	Test me with "pronouns of ahab / pronouns of pequod / x it / x her / x him".

Example: * They-them - Verb viewpoint follows either referent or pronoun.

	*: "They-them"
	
	Include Non-binary Gender by Sadie de Might.
	Mary is a woman.
	There is proper-named plural-named woman called The Fates.
	Chris is a person. Pertinent pronouns about Chris: they-them appertains.
	The Lab is a room. Mary, Chris, and the Fates are in the Lab.
	To smile is a verb. Instead of examining someone: say "[The noun] [smile] at you. [They] [have] as [their] pronouns [pronouns of the noun].".
	
	Test me with "x mary / x fates / x chris".

Notice how this prints "smiles" for both of the individual people, since they're each a singular person, while The Fates, a collection of three people, "smile".  On the other hand, this prints "they have" for both the fates and the individual Chris, since "they has" is ungrammatical.

Example: * Dependency - Using different pronouns at differen times.

As with any rulebook, the behavior can depend on the state of the world.

	*: "Dependency"

	Include Non-binary Gender by Sadie de Might.
	The Lab is a room. There is a wearable thing called the Spectacles of Truth. It is in the Lab.
	Mary is a woman in the Lab. The description is "Mary smiles pleasantly.[if the player is wearing the Spectacles] But you can see dimly that she's just a humainoid costume being worn by the demon Moloch."
	Instead of touching Mary: say "[if the player is wearing the Spectacles]The demon[else]Mary[end if] glares at you and shakes [regarding Mary][their] head.".
	Pertinent pronouns for Mary when the player is wearing the Spectacles: neuter pronouns appertain.
	Pertinent pronouns for Mary: she-her appertains.
	
	Test me with "x mary / touch her / x it / pronouns reset / wear spectacles / x mary / touch it".

Example: * Mutability - Changing what pronouns are used.

Rather than writing rules for every possible situation, sometimes it's easier to just give a thing a property specifying a pertinent pronoun lexeme, which can be changed like any other property.  Name the property "explicit pronouns", and it'll be used instead of pronouns implied by the kind of object.

This extension even includes an action to set this property during play, though it is not included for release.

	*: "Mutability"

	Include Non-binary Gender by Sadie de Might.
	The Lab is a room. There is a wearable thing called the Goggles of Double Vision. It is in the Lab.
	Chris is a female person in the Lab. Chris has a pronoun lexeme called explicit pronouns. The explicit pronouns are they-them.
	Pertinent pronouns for Chris when the player is wearing the Goggles: plural pronouns appertain.

	Test me with "pronouns of chris / set pronouns of chris to he-him / pronouns chris / set pronouns chris implicit / pronouns chris / wear goggles / pronouns chris / set pronouns chris he-him / drop goggles / pronouns chris".

Notice how setting the explicit pronouns property to "the implicit pronouns" doesn't necessarily go back to the initial state when the game started.  

Example: ** Layers - The layers of deciding on pronouns.

As the previous example shows, there are several stages to deciding what pronouns an object has.  For one thing, the "pertinent pronouns rules" is just one possible rulebook that can list pronouns. For another thing, using a pronoun to talk about an object is jut one thing that can be done with such a rulebook.

We can provide a different rulebook to provide the listing, and we can use the listing to do somehing else. That's also defined by a rule.

	*: "Layers"

	Include Non-binary Gender by Sadie de Might.
	Alice and Bob are people. The Lab is a room. Everyone is in the Lab.

	The say third person pronouns rulebook is a personed pronoun lexeme based rulebook.
	Say third person pronouns rule about a third-person personed pronoun lexeme (called P): say "[P], ".
	
	The narrow pronoun understanding rules are an object based rulebook.
	The broad pronoun understanding rules are an object based rulebook.
	Broad pronoun understanding for Alice (this is the Alice as she rule): she-her appertains.
	The Alice as she rule is listed in the narrow pronoun understanding rules.
	Broad pronoun understanding for Alice: I-me appertains.
	Broad pronoun understanding for Alice: they-them appertains.
	Broad pronoun understanding for Bob: they-them appertains.
	Broad pronoun understanding for Bob (this is the Bob as he rule): he-him appertains.
	The Bob as he rule is listed in the narrow pronoun understanding rules.
	
	To say list of pronouns for (N - a person) using (R - an object based rulebook):
		apply the say third person pronouns rulebook to pertinent pronouns according to R for N.

	Instead of examining someone:
		say "A narrow understanding of [the noun]'s third-person pronouns includes [list of pronouns for the noun using the narrow pronoun understanding rules] and that's all, while a broad understanding encompasses [list of pronouns for the noun using the broad pronoun understanding rules] which is better.".
		
	Test me with "x alice / x bob".

Example: ** New Pronouns - Adding a new pronoun lexeme and using it during play.

Adding a new pronoun lexeme does require a somewhat arcane incantation, though a short one.

	*: "New Pronouns"

	Include Non-binary Gender by Sadie de Might.
	Use pronoun debugging of at least 1.
	
	There is a pronoun lexeme called xe-xem. Use pronoun form space of at least 8.  Use pronoun referent space of at least 6.  Use pronoun descriptor space of at least 17.
	To set the forms of (P - xe-xem): (- PronounSetForms({P}, 'xe', 'xem', 'xyr'); -).

	The Lab is a room.
	Chris is a person in the Lab. Chris wears a green cravat. Pertinent pronouns for Chris: they-them appertains.
	Pat is a person in the lab. Pat wears a purple cravat. Pertinent pronouns for Pat: xe-xem appertains.

	Test me with "pronouns of chris and pat / pronouns / x them / x xem / x xyr cravat".

There are several parts to this.  First is adding a new pronoun lexeme value. Next, there is a request to allocate more space for storing how to say the new lexeme, and more space for how to understand the lexeme.

Then, there's specifying the pronoun forms for the new pronoun lexeme.  This is requires using I6 code, invoked via an I7 phrase, which must be "To set the forms of (P - ...)", with the specific new lexeme as the value the phrase applies to. The lexeme value must be given a name ("P" is a good choice), which also allows the name to be used in the I6 code. In the simplest case, the name of the lexeme must be followed by three pronoun forms, each enclosed in single quotes.

The first form is the form that would be printed by "[they]", the second by "[them]", and the third by "[their]". The "them" and "their" forms become available for use in commands during play.

Finally, if you need additional help debugging a use of this extension, you can request that it print informative messages as it works.  Since much of the extension's work happens before play begins, this is requested via a "use option".  The higher the value given, the more information that gets printed.

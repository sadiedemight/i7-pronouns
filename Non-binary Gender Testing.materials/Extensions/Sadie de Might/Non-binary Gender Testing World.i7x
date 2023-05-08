Non-binary Gender Testing World by Sadie de Might begins here.

"An extension that only exists to allow the Non-binary Gender Testing extension project to reuse code between multiple tests."

Include Non-binary Gender by Sadie de Might.
Use pronoun debugging of at least 0.

The Void is a room. Everyone is in The Void.

Understand "examine [things]" as examining.

Requesting pronouns about is an action out of world and applying to one topic.
Report requesting pronouns about:
	if the topic understood is a topic listed in Table of Pronoun Topics:
		expect the pronouns for the regarding entry to be the expected entry with person; 
		say "[The pronouns demo about the regarding entry].";
	otherwise:
		say "I don't know what you mean.".
Understand "pronouns about [text]" as requesting pronouns about.

Use scoring.

To expect (A - some text) to be about (T - some text) with pronouns (P - a personed pronoun lexeme) called (U - some text) but using forms of (Q - a personed pronoun lexeme) forcing nominative those (F - a truth state):
	let V be the viewpoint of verbs agreeing with P;
	let E be the substituted form of "Considering [T], as for [if F is false][accusative those of Q][else][nominative those of Q][end if], [they of Q] [adapt the verb have from V] as [their of Q] pronouns [P]. [nominative those of Q in sentence case] [adapt the verb are from V] able to use such pronouns as [theirs of Q] for [themselves of Q]. [U] [adapt the verb are from third person plural] also for others to use on [them of Q].";
	[TODO: Fix this in ZCODE, where it crashes silently: let Asub be the substituted form of A;]
	unless A exactly matches the text E:
		if A matches the text "?":
			decrement the score;
			say "[bold type]";
		otherwise unless E matches the text "?":
			decrement the score;
			say "[bold type]";
		otherwise:
			say "(Not actually treating this as an error) [italic type][no line break]";
		say "The following pronouns should be[roman type][line break][run paragraph on][E][line break][run paragraph on][italic type]but are actually[roman type][line break][run paragraph on]".

To expect (A - some text) to be about (T - some text) with pronouns (P - a personed pronoun lexeme) called (U - some text):
	expect A to be about T with pronouns P called U but using forms of P forcing nominative those false.

To expect the pronouns for (T - some text) to be (P - a personed pronoun lexeme):
	expect "[The pronouns demo about T]." to be about "the pronouns of [T]" with pronouns P called "[their of P in sentence case] pronouns".

To decide which personed pronoun lexeme is the expected player pronouns:
	choose the row with target of the player in the Table of Expected Pronouns;
	let P be the third person entry;
	[The Trans Menace unreasonably compares its pronouns with the implicit pronouns so as to demonstrate printing an error, but it makes no sense to make further changes to this expectation.]
	if P is the implicit pronouns, decide on P with person;
	let V be the story viewpoint;
	unless story viewpoint overrides player pronoun number:
		if P is semantically singular:
			if V is:
				-- first person plural: now V is first person singular;
				-- second person plural: now V is second person singular;
				-- third person plural: now V is third person singular;
		otherwise:
			if V is:
				-- first person singular: now V is first person plural;
				-- second person singular: now V is second person plural;
				-- third person singular: now V is third person plural;
	if V is:
		-- first person singular: decide on I-me with person;
		-- first person plural: decide on we-us with person;
		-- second person singular: decide on you-your singular with person;
		-- second person plural: decide on the you-your plural with person;
		-- third person singular:
			if there is a player gendered third person singular entry and (P is semantically plural or (P is the neuter pronouns and the neuter player forced binary pronouns option is active)):
				decide on the player gendered third person singular entry with person;
		-- third person plural:
			if P is semantically singular, decide on plural animate pronouns with person;
	decide on P with person.

Carry out requesting the personed pronouns of:
	let P be the third person corresponding to a target of the noun in the Table of Expected Pronouns;
	unless the noun is the player:
		expect "[The pronouns demo about the noun]." to be about "[the noun]" with pronouns P with person called "[The noun][apostrophe][unless P is semantically plural]s[end if] pronouns";
	otherwise:
		let E be the expected player pronouns;
		let F be E;
		if the plural player forces plural pronouns option is active and story viewpoint overrides player pronoun number and P is semantically plural, now F is the plural pronouns with person;
		let N be whether or not the player forces nominative those option is active;
		expect "[The pronouns demo about the noun]." to be about "[themselves of E]" with pronouns E called "[their of E in sentence case] pronouns" but using forms of F forcing nominative those N.

Visiting is an action out of world applying to one visible thing.
Understand "visit [things]" as visiting.
Carry out visiting:
	say "[noun]: [no line break][run paragraph on]";
	try examining the noun;
	if the noun is not a person:
		say "Not visiting [the noun]; [they]['re] not a person.[paragraph break]";
		stop the action;
	now the player is the noun;
	try requesting the personed pronouns of the noun;
	say "[conditional paragraph break]";
	now the player is yourself.

The visit test case is a number that varies. The visit test case is usually -1.
Use expect story viewpoint to override player pronoun number although disabled translates as (- Constant PRONOUN_FORCE_VIEWPOINT_NUMBER; -).

Visiting case is an action out of world applying to one visible thing.
Understand "visit case [things]" as visiting case.
Carry out visiting case:
	let T be the story tense;
	let F be whether or not the story viewpoint overrides player pronoun number;
	let V be the story viewpoint;
	if the noun is The Trans Menace:
		now the visit test case is the visit test case plus one;
		try requesting the score;
	let N be the visit test case;
	if the remainder after dividing N by 6 is:
		-- 0: now the story viewpoint is first person singular;
		-- 1: now the story viewpoint is second person singular;
		-- 2: now the story viewpoint is third person singular;
		-- 3: now the story viewpoint is first person plural;
		-- 4: now the story viewpoint is second person plural;
		-- 5: now the story viewpoint is third person plural;
	now N is N / 6;
	if the remainder after dividing N by 5 is:
		-- 0: now the story tense is present tense;
		-- 1: now the story tense is past tense;
		-- 2: now the story tense is future tense;
		-- 3: now the story tense is perfect tense;
		-- 4: now the story tense is past perfect tense;
	now N is N / 5;
	if the story viewpoint overrides player pronoun number option is active:
		set player pronoun number override by story viewpoint to whether or not (the remainder after dividing N by 2 is 1) or (the expect story viewpoint to override player pronoun number although disabled option is active);
		now N is N / 2;
	if N is not 0:
		say "All cases tested (#[the visit test case]).";
	otherwise:
		if the noun is The Trans Menace, say "Test case #[the visit test case]: [story viewpoint], story viewpoint [if story viewpoint overrides player pronoun number]overrides[else] does not override[end if] player pronoun number, [story tense]";
		try visiting the noun;
	now the story tense is T;
	if the story viewpoint overrides player pronoun number option is active, set player pronoun number override by story viewpoint to F;
	now the story viewpoint is V.

Table of Pronoun Topics
Topic	Regarding	Expected
"this place"	"[The Void]"	the neuter pronouns
"twins"	"[the list of all twins]"	the plural pronouns
"zero"	"[0 in words] thing[s][regarding 0]"	the neuter pronouns [This should use plural verbs, just as [s] pluralizes.]
"one"	"[1 in words] thing[s][regarding 1]"	the neuter pronouns
"many"	"[3 in words] thing[s][regarding 3]"	the plural pronouns
"negative"	"[-2 in words] thing[s][regarding -2]"	the neuter pronouns [This should(?) use plural verbs, just as [s] pluralizes.]

There is a neuter person called The Trans Menace. The description is "A person deemed neuter by the system, but expecting implicit pronouns in order to show misgendering.".  The Trans Menace wears the blank nametag. The description of the blank nametag is "A blank nametag, worn by the Trans Menace to confuse people.".
There is a proper-named object called Physics. Physics is in the Void. The description is "A notion, rather than a thing.".
Lilith is a woman. The description is "A woman.". Lilith wears Lilith's nametag. The description of Lilith's nametag is "Lilith's nametag.".
Adam is a man. The description is "A man.".
Eve is a female person. The description is "A female person, but not a woman.".
Lucifer is a neuter male person. The description is "A neuter person, also male.".
Hel is a neuter female person. The description is "A neuter person, also female.".
Legion is a plural-named man. The description is "A plural man.".
There is a plural-named woman called The Fates. The description is "A plural woman.".
Kana is an ambiguously plural woman. The description is "An ambigously plural woman". Kana wears Kana's nametag. The description of Kana's nametag is "Kana's nametag.".
A twin is a kind of person.
Casta is a female twin. The description is "A female twin, but not a woman.".
Pollux is a male twin. The description is "A male twin, but not a man.". Pollux wears Pollux's nametag. The description of Pollux's nametag is "Pollux's nametag.".
There is an animal called The Serpent. The description is "An animal with a title.".
There is a neuter animal called a worm. The description is "An unimportant neuter animal.".
There is a female animal called some bees. The description is "Some unnamed female animals.".
Golem is a thing in the Void. The description is "A thing.".
Lady is a person. The description is "A person with she-her pronouns.". Lady wears the lady's nametag. The description of the lady's nametag is "The lady's nametag.".
Lord is a person. The description is "A person with he-him pronouns.".
Joker is a person. The description is "A person with they-them pronouns.".
Jester is a person. The description is "A person with ze-hir pronouns.".
Jotin is a person. The description is "A person with neuter pronouns.".
There is a improper-named person called sorority sisters. The description is "Some unnamed people.".
Swarm is a person. The description is "A plural person with plural they-them pronouns.".
Cloud is a person. The description is "A plural person with plural xey-xem pronouns.". Cloud wears Cloud's nametag. The description of Cloud's nametag is "Cloud's nametag.".

Table of Expected Pronouns
target (an object)	third person	player gendered third person singular	topic
The Trans Menace	implicit pronouns	implicit pronouns	"the elephant in the room"
Physics	neuter pronouns	--	"the rules of reality"
Lilith	she-her	--	"our heroine"
Adam	he-him	--	--
Eve	she-her	--	--
Lucifer	neuter pronouns	he-him	--
Hel	neuter pronouns	she-her	--
Legion	plural pronouns	he-him	--
Fates	plural pronouns	she-her	--
Kana	she-her	--	"not so much void as null"
Casta	she-her	--	--
Pollux	he-him	--	--
The Serpent	he-him	--	--
worm	neuter pronouns	he-him	--
bees	plural pronouns	she-her	--
Golem	neuter pronouns	--	--
yourself	[a sentinel to separate these rows from those above]	--	--
Lady	she-her	--	"the dame"
Lord	he-him	--	--
Joker	Joker's pronouns	--	--
Jester	Jester's pronouns	--	--
Jotin	neuter pronouns	he-him	--
sorority sisters	the sorority pronouns	he-him	--
Swarm	plural pronouns	he-him	--
Cloud	Cloud's pronouns	he-him	"a nimbus"

Test pronouns with "pronouns all / pronouns about this place/ pronouns about zero / pronouns about one / pronouns about many / pronouns about negative / pronouns twins / pronouns about twins / pronouns about gemini".
Test lilith with "pronouns reset / x her / x her nametag / x lilith / x him / x his nametag / x her / x her nametag / x their nametag".
Test kana with "pronouns reset / x her / x her nametag / x kana / x him / x his nametag / x her / x her nametag / x their nametag".
Test lady with "pronouns reset / x her / x her nametag / x lady / x him / x his nametag / x her / x her nametag / x their nametag".
Test cloud with "pronouns reset / x xem / x xir nametag / x cloud / x him / x his nametag / x xem / x xir nametag / x their nametag".

Chapter - Use Explicit Pronouns

Some pronoun lexemes are ze-hir and xey-xem.  Use pronoun form space of at least 9.  Use pronoun referent space of at least 6.  Use pronoun descriptor space of at least 18.
To set the forms of (P - ze-hir): (- PronounSetForms({P}, 'ze', 'hir', 'hir'); -).
To set the forms of (P - xey-xem): (- PronounSetForms({P}, 'xey', 'xem', 'xir', PRONOUN_PLURAL); -).

Joker's pronouns are always they-them.
Jester's pronouns are always ze-hir.
The sorority pronouns are always plural animate pronouns.
Cloud's pronouns are always xey-xem.
A person has a pronoun lexeme called explicit pronouns.

When play begins:
	let E be false;
	repeat through Table of Expected Pronouns:
		if the target entry is yourself:
			now E is true;
		otherwise if E is true:
			now the explicit pronouns of the target entry are the third person entry.


Non-binary Gender Testing World ends here.

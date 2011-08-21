"
This browser shows the result of applying method tally to a given computation block.

Example:
self openOn: [10000 timesRepeat: [1.23 printString]]
"
Class {
	#name : #GTMessageTallyBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTMessageTallyBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Message Tally'.
	browser
		column: #messages;
		column: #details.
	(browser transmit)
		to: #messages;
		andShow: [ :a | self messagesIn: a ].
	(browser transmit)
		to: #details;
		from: #messages;
		andShow: [ :a | self sourceCodeIn: a ].
	^ browser
]

{ #category : #building }
GTMessageTallyBrowser >> messagesIn: a [
	^ (a tree)
		title: 'Message tree';
		children: [ :each | each sonsOver: -1 ];
		morphicSelectionAct: [ :list | GTUtils browseMethod: list selection method ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			on: $b
			entitled: 'Browse (b)';
		format: [ :each | Text fromString: (GTUtils printCompiledMethod: each method) , ' (' , each tally printString , ')']
]

{ #category : #building }
GTMessageTallyBrowser >> openOn: aBlock [
	^ super openOn: (MessageTally new spyEvery: 1 on: aBlock; yourself)
]

{ #category : #building }
GTMessageTallyBrowser >> sourceCodeIn: a [
	^ (a text)
		title: [ :each | GTUtils printCompiledMethod: each method ];
		morphicAct: [ :text :each | GTUtils browseMethod: each method ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			entitled: 'Browse';
		forSmalltalk: [ :each | each method methodClass ];
		display: [ :each | each method methodClass sourceCodeAt: each method selector ifAbsent: [ 'unknown' ] ]
]

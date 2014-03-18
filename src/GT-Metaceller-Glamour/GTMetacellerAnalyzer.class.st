Class {
	#name : #GTMetacellerAnalyzer,
	#superclass : #GTMetacellerBrowserTemplate,
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #building }
GTMetacellerAnalyzer >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Analyze ', self configuration configName.
	browser
		act: [ :b | 
			Workspace new
				contents: self helpText;
				openLabel: 'Metaceller analyze help' ]
		icon: GLMUIThemeExtraIcons glamorousHelp
		entitled: 'Help'.
	browser
		row: [ :r | r
			column: #versions;
			column: #groups ];
		row: #details;
		row: #buttons size: 30.
	browser transmit
		to: #versions;
		andShow: [ :a | self versionsIn: a ].
	browser transmit
		to: #groups;
		andShow: [ :a | self groupsIn: a ].
	browser transmit
		to: #details;
		andShow: [ :a | self details: a ].
	browser transmit
		from: #versions;
		to: #details;
		andShow: [ :a | self details: a ].
	browser transmit
		from: #groups;
		to: #details;
		andShow: [ :a | self details: a ].
	browser transmit
		to: #buttons;
		andShow: [ :a | self buttonsIn: a ].
	browser transmit
		from: #versions; from: #groups;
		to: #buttons;
		andShow: [ :a | self buttonsForVersionsAndGroups: a ].
	^ browser
]

{ #category : #building }
GTMetacellerAnalyzer >> buttonsForVersionsAndGroups: aBrowser [
	aBrowser actionList
		act: [ :entity :version :groups | self validateVersion: version groups: groups ] entitled: 'Validate';
		act: [ :entity :version :groups | self testVersion: version groups: groups ] entitled: 'Test';
		allowNil;
		yourself.
	aBrowser actionList
		act: [ :entity :version :groups | self validateVersion: version groups: groups ] entitled: 'Validate';
		act: [ :entity :version :groups | self testVersion: version groups: groups ] entitled: 'Test';
		allowAllNil;
		yourself	
]

{ #category : #building }
GTMetacellerAnalyzer >> buttonsIn: aBrowser [
	aBrowser actionList
		act: [ :entity | self validateConfiguration ] entitled: 'Validate';
		act: [ :entity | self testConfiguration ] entitled: 'Test';
		yourself
]

{ #category : #actions }
GTMetacellerAnalyzer >> testConfiguration [
	self configuration test
]

{ #category : #actions }
GTMetacellerAnalyzer >> testItems: aGroupList [
	self configuration testItems: aGroupList
]

{ #category : #actions }
GTMetacellerAnalyzer >> testVersion: aVersion groups: aGroupList [
	aVersion ifNil: [ ^self testItems: aGroupList ].
	aVersion test: aGroupList
]

{ #category : #actions }
GTMetacellerAnalyzer >> validateConfiguration [
	self configuration validate
]

{ #category : #actions }
GTMetacellerAnalyzer >> validateItems: aGroupList [
	self configuration validateItems: aGroupList
]

{ #category : #actions }
GTMetacellerAnalyzer >> validateVersion: aVersion groups: aGroupList [
	aVersion ifNil: [ ^self validateItems: aGroupList ].
	aVersion validate: aGroupList
]

Extension { #name : #ThemeIcons }

{ #category : #'*GT-SpotterExtensions-Core' }
ThemeIcons class >> gtExampleThemeIcons [
	<gtExample>
	<label: 'Icon Theme'>
	
	^ Smalltalk ui icons
]

{ #category : #'*GT-SpotterExtensions-Core' }
ThemeIcons >> spotterForIconsFor: aStep [
	<spotterOrder: 10>
	self flag: #maybeRewriteForDirectStreaming.
	aStep listProcessor
		title: 'Icons';
		allCandidates: [ 
			self iconSelectors asSortedCollection 
				collect: [ :each | each -> (self perform: each) ] ];
		itemIcon: #value;
		itemName: #key;
		actLogic: [ :association | (self class lookupSelector: association key) browse ];
		filter: GTFilterSubstring
]

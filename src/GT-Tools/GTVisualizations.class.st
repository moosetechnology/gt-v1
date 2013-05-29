Class {
	#name : #GTVisualizations,
	#superclass : #Object,
	#category : #'GT-Tools-Utils'
}

{ #category : #'as yet unclassified' }
GTVisualizations >> viewPragmaConstellation [
	"self new viewPragmaConstellation"
	| view |
	view := ROMondrianViewBuilder new.
	self viewPragmaConstellationOn: view.
	^ view openWithStatusbar setLabel: 'Pragma Constellation'
]

{ #category : #'as yet unclassified' }
GTVisualizations >> viewPragmaConstellationOf: pragmas on: view [
	
	| pragmaTypes |
	pragmaTypes := pragmas groupedBy: #keyword.
	view shape ellipse fillColor: Color lightGray; borderWidth: 0.
	view nodes: (pragmas collect: [:each | each method methodClass] as: Set).
	view shape rectangle withoutBorder
		fillColor: Color gray;
		withText: #name;
		fontColor: Color white;
		linearFontSize: [:each | 
			(pragmaTypes at: each) size ] within: pragmaTypes keys.
	view nodes: pragmaTypes keys.
	view shape line color: Color veryVeryLightGray; width: 3.
	view edges: pragmas from: [:each | each method methodClass] to: #keyword.
	view forceBasedLayout
]

{ #category : #'as yet unclassified' }
GTVisualizations >> viewPragmaConstellationOn: view [
	
	| pragmas |
	pragmas := OrderedCollection new.
	Object withAllSubclassesDo: [:each |
		Pragma withPragmasIn: each do: [:p |
			pragmas add: p]].
	self viewPragmaConstellationOf: pragmas on: view
]

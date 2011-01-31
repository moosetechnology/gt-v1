Class {
	#name : #GTVisualizations,
	#superclass : #Object,
	#category : #'GT-Tools-Utils'
}

{ #category : #'as yet unclassified' }
GTVisualizations >> viewPragmaConstellation [
	"self new viewPragmaConstellation"
	| view |
	view := MOViewRenderer new.
	self viewPragmaConstellationOn: view.
	view openWithStatusbar
]

{ #category : #'as yet unclassified' }
GTVisualizations >> viewPragmaConstellationOf: pragmas on: view [
	
	| pragmaTypes |
	pragmaTypes := pragmas groupedBy: #keyword.
	view shape ellipse fillColor: Color lightGray; withoutBorder.
	view nodes: (pragmas collect: [:each | each method methodClass]).
	view shape rectangle 
		text: #name;
		fillColor: Color gray;
		fontColor: Color white;
		linearFontSize: [:each | 
			(pragmaTypes at: each) size ] within: pragmaTypes keys;
		withoutBorder.
	view nodes: pragmaTypes keys.
	view shape line color: Color veryVeryLightGray; width: 3.
	view edges: pragmas from: [:each | each method methodClass] to: #keyword.
	view layout: MOGraphVizLayout new.

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

"
self openOn: SmalltalkSyntaxTutorial.
"
Class {
	#name : #GTProfStef,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #'as yet unclassified' }
GTProfStef class >> openOn: tutorial [
	^ super openOn: (ProfStef goOn: tutorial viewedWith: GTProfStefNoView new)
]

{ #category : #building }
GTProfStef >> buildBrowser [
	browser := GLMFinder new.
	browser title: 'Prof Stef'.
	browser text
		forSmalltalk;
		display: [ :lesson | lesson lessonInstance lesson ];
		when: [:lesson | lesson isKindOf: TutorialNode];
		title: [:lesson | lesson lessonInstance title];
		selectionPopulate: #selection
			on: $o
			entitled: 'Open (o)'
			with: [ :text :entity | 
				| result |
				result := [Compiler 
					evaluate: text selectedText
					for: entity
					logged: false] on: Error do: [nil].
				(result isNil or: [result isKindOf: GTProfStefNoView]) ifTrue: [nil] ifFalse: [result] ];
		selectionAct: 
				[ :text :entity | 
				(Compiler 
					evaluate: text selectedText
					for: entity
					logged: false) inspect ]
			on: $/
			entitled: 'Inspect (/)';
		populate: #selection icon: GLMUIThemeExtraIcons glamorousRight entitled: 'Next lesson'  with: [:text :lesson | ProfStef next ].
	^ browser
]

{ #category : #opening }
GTProfStef >> entity [
	^ ProfStef goOn: SmalltalkSyntaxTutorial viewedWith: GTProfStefNoView new
]

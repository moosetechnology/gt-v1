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
	browser text
		forSmalltalk;
		display: [ :lesson | lesson lesson ];
		when: [:lesson | lesson isKindOf: Lesson];
		title: 'Evaluator';
		update: #selection
			on: $o
			entitled: 'Open (o)'
			with: 
				[ :text :entity | 
				Compiler 
					evaluate: text selectedText
					for: entity
					logged: false ];
		act: 
				[ :text :entity | 
				(Compiler 
					evaluate: text selectedText
					for: entity
					logged: false) inspect ]
			on: $/
			entitled: 'Inspect (/)'.
	^ browser
]

{ #category : #opening }
GTProfStef >> entity [
	^ ProfStef goOn: SmalltalkSyntaxTutorial viewedWith: GTProfStefNoView new
]

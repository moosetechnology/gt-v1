"
self open
"
Class {
	#name : #GTProfStefEncyclopedia,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTProfStefEncyclopedia >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Prof Stef Encyclopedia'.
	browser column: #lessons; column: #details span: 4.
	browser transmit to: #lessons; andShow: [:a | 
		a list 
			title: 'Tutorials';
			send: [:class | ProfStef goOn: class viewedWith: GTProfStefNoView new ]
			"morphicSelectionAct: [:each | each selection browse ] entitled: 'Browse'"].
	browser transmit from: #lessons; to: #details; andShow: [:a | 
		a custom: GTProfStef new browser noTitle ].
	^ browser
]

{ #category : #opening }
GTProfStefEncyclopedia >> entity [
	^ AbstractTutorial allSubclasses 
]

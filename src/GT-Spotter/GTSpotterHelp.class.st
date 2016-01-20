"
A helper class containing the help for GT Spotter.
"
Class {
	#name : #GTSpotterHelp,
	#superclass : #CustomHelp,
	#category : #'GT-Spotter'
}

{ #category : #accessing }
GTSpotterHelp class >> bookName [ 
	^'GT Spotter'
]

{ #category : #documentation }
GTSpotterHelp class >> overview [
	^ HelpTopic 
		title: 'Overview'
		contents: 
'GT Spotter is a moldable object search tool that is part of Pharo and was developed as part of the Glamorous Toolkit project (http://gt.moosetechnology.org)'
]

{ #category : #accessing }
GTSpotterHelp class >> pages [
	^#(overview)
]

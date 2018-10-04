Class {
	#name : #GTAPillarPresentation,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Pillar'
}

{ #category : #building }
GTAPillarPresentation >> build [
	self generateIndexPage.
]

{ #category : #building }
GTAPillarPresentation >> generateIndexPage [
	"self new build"
	PRHTMLWriter defaultConfigurations anyOne
	    inputString: '{{title: Spotter Usage Report}}
!Spotter

+Figure: Spotter>file://spotter-example.png+
	
!Spotter Usage Report

Some text with *a link to Pharo>http://www.pharo.org*.

!!Timeline View

Timeline of all computers.

[[[eval=true
| view |
view := GTATimelineBuilder new 
	computers: GTAAnnouncements spotterUsersAndDevelopers; 
	width: 800;
	build; 
	view.
RTHTML5Exporter new insert: view named: ''Spotter Timeline'' inPillarStream: stream.
]]]

!!Activity View

The following figure depicts some Spotter usage we detect.

+Figure: Some typical usage patters>file://sessions-classification.png+

	';
	    outputFile: 'index.html' asFileReference;
	    export

]

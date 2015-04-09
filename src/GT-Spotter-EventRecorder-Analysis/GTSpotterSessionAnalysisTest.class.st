"
A GTSpotterDiveInLevelCommandTest is a test class for testing the behavior of GTSpotterDiveInLevelCommand
"
Class {
	#name : #GTSpotterSessionAnalysisTest,
	#superclass : #TestCase,
	#instVars : [
		'analysis'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #accessing }
GTSpotterSessionAnalysisTest >> session1 [
	^ GTSpotterSession new
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderContextChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderCategorySelectedEvent new;
		add: GTSpotterRecorderDiveInCategoryEvent new;
			add: GTSpotterRecorderContextChangedEvent new;
			add: GTSpotterRecorderSelectedCandidateChangedEvent new;
			add: GTSpotterRecorderCategorySelectedEvent new;
			add: GTSpotterRecorderDiveOutEvent new;
		add: GTSpotterRecorderDiveInElementEvent new;
			add: GTSpotterRecorderContextChangedEvent new;
			add: GTSpotterRecorderSelectedCandidateChangedEvent new;
			add: GTSpotterRecorderCategorySelectedEvent new;
			add: GTSpotterRecorderDiveInCategoryEvent new;
				add: GTSpotterRecorderContextChangedEvent new;
				add: GTSpotterRecorderSelectedCandidateChangedEvent new;
				add: GTSpotterRecorderCategorySelectedEvent new;
				add: GTSpotterRecorderDiveOutEvent new;
			add: GTSpotterRecorderContextChangedEvent new;
			add: GTSpotterRecorderSelectedCandidateChangedEvent new;
			add: GTSpotterRecorderCategorySelectedEvent new;
			add: GTSpotterRecorderDiveOutEvent new;
		add: GTSpotterRecorderContextChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderCategorySelectedEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		yourself
]

{ #category : #accessing }
GTSpotterSessionAnalysisTest >> session2 [
	^ GTSpotterSession new
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderShowPreviewEvent new;
		add: GTSpotterRecorderContextChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderCategorySelectedEvent new;
		add: GTSpotterRecorderSearchFinishedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderCategorySelectedEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		yourself
]

{ #category : #accessing }
GTSpotterSessionAnalysisTest >> session3 [
	"Miss-steps"
	^ GTSpotterSession new
		add: GTSpotterRecorderOpenEvent new;
		add: GTSpotterRecorderContextChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderCategorySelectedEvent new;
		add: GTSpotterRecorderContextChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderSelectedCandidateChangedEvent new;
		add: GTSpotterRecorderCategorySelectedEvent new;
		add: GTSpotterRecorderDiveInCategoryEvent new;
			add: GTSpotterRecorderContextChangedEvent new;
			add: GTSpotterRecorderSelectedCandidateChangedEvent new;
			add: GTSpotterRecorderCategorySelectedEvent new;
			add: GTSpotterRecorderSearchFinishedEvent new;
			add: GTSpotterRecorderDiveOutEvent new;
		add: GTSpotterRecorderSearchFinishedEvent new;
		add: GTSpotterRecorderDiveInElementEvent new;
			add: GTSpotterRecorderContextChangedEvent new;
			add: GTSpotterRecorderSelectedCandidateChangedEvent new;
			add: GTSpotterRecorderCategorySelectedEvent new;
		add: GTSpotterRecorderExitAnnouncementEvent new;
		yourself
]

{ #category : #running }
GTSpotterSessionAnalysisTest >> setUp [
	super setUp.
	analysis := GTSpotterSessionAnalysis new.
	
]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testMissStepsSession1 [
	| session |
	analysis session: self session1.
	analysis execute.
	session := analysis session.
	self assert: session size equals: 27.
	self assert: session numberOfMissSteps equals: 1.
	self assert: (session at: 6) isMissStep.
]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testMissStepsSession2 [
	| session |
	analysis session: self session2.
	analysis execute.
	session := analysis session.
	self assert: session size equals: 11.
	self assert: session numberOfMissSteps equals: 0.
]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testMissStepsSession3 [
	| session |
	analysis session: self session3.
	analysis execute.
	session := analysis session.
	self assert: session size equals: 20.
	self assert: (session at: 9) isMissStep.
	self deny: (session at: 16) isMissStep.
	self assert: session numberOfMissSteps equals: 1.
]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testRootsSession1 [
	| roots |
	analysis session: self session1.
	analysis execute.
	roots := analysis session roots.
	self assert: roots size equals: 11.
	self assert: (roots at: 6) children size equals: 4.
	self assert: (roots at: 1) children size equals: 0.
	self assert: (roots at: 7) children size equals: 8.
	self assert: ((roots at: 7) children at: 4) children size equals: 4.

]

{ #category : #tests }
GTSpotterSessionAnalysisTest >> testRootsSession2 [
	| session |
	analysis session: self session2.
	analysis execute.
	session := analysis session.
	self assert: session size equals: 11.
	self assert: (session at: 4) categoryEvent equals: (session at: 5).
	self assert: (session at: 5) elementSelectionEvents size equals: 3.
	self assert: (session at: 5) elementSelectionEvents first equals: (session at: 4).
	self assert: (session at: 5) elementSelectionEvents second equals: (session at: 7).
	self assert: (session at: 5) elementSelectionEvents third equals: (session at: 8).
	self assert: (session at: 9) categoryEvent equals: (session at: 10).
	self assert: (session at: 10) elementSelectionEvents size equals: 1.
	self assert: (session at: 10) elementSelectionEvents first equals: (session at: 9).

]

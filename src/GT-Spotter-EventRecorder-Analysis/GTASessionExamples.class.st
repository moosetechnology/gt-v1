Class {
	#name : #GTASessionExamples,
	#superclass : #Object,
	#category : #'GT-Spotter-EventRecorder-Analysis-Tests'
}

{ #category : #accessing }
GTASessionExamples class >> session1 [
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
GTASessionExamples class >> session2 [
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
GTASessionExamples class >> session3 [
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

{ #category : #accessing }
GTASessionExamples class >> session4 [
	^ GTSpotterSession new
		add: GTSpotterRecorderOpenEvent new; 
		add: GTSpotterRecorderShowPreviewEvent new; 
		add: GTSpotterRecorderContextChangedEvent new; 
		add: GTSpotterRecorderSelectedCandidateChangedEvent new; 
		add: GTSpotterRecorderCategorySelectedEvent new; 
		add: GTSpotterRecorderContextChangedEvent new; 
		add: GTSpotterRecorderSelectedCandidateChangedEvent new; 
		add: GTSpotterRecorderSelectedCandidateChangedEvent new; 
		add: GTSpotterRecorderCategorySelectedEvent new; 
		add: GTSpotterRecorderContextChangedEvent new; 
		add: GTSpotterRecorderContextChangedEvent new; 
		add: GTSpotterRecorderSelectedCandidateChangedEvent new; 
		add: GTSpotterRecorderSelectedCandidateChangedEvent new; 
		add: GTSpotterRecorderCategorySelectedEvent new; 
		add: GTSpotterRecorderSearchFinishedEvent new; 
		add: GTSpotterRecorderSelectedCandidateChangedEvent new; 
		add: GTSpotterRecorderSelectedCandidateChangedEvent new; 
		add: GTSpotterRecorderSelectedCandidateChangedEvent new; 
		add: GTSpotterRecorderSelectedCandidateChangedEvent new; 
		add: GTSpotterRecorderActOnEvent new; 
		yourself
]

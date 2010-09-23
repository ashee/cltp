09/22/2010
==========

## Overall
1. Highlight tabs
2. Remove hardcode - Academic Year and Period from the top bar

## Security and access control
1. Show customized top menu based on roles
2. Restrict unauthorized access (e.g. list feedbacks should not be visible to students)
3. List Encounters - *My Encounters* if student else *All Encounters*

## View Encounter
1. Refresh display on add resource
2. Change age column to dob in the database
3. Re-factor code to use dob as opposed to age

## Edit encounter
2. Fix pop-up dx selection tool


## Resource Tab
1. Reduce the clutter on "All Resource" tab
2. Wire filter logic to filter out private links from others
3. Rating module


## Feedback
1. Students can just submit feedback

## Google Analytics
1. Add GA code
2. Customize GA to pass user info

## Reporting
1. Report landing page
2. Reports - query and grid

## Vaculty View
1. Customize menu options (top toolbar)

## Testing
1. Create student/faculty/admin users
2. Create 500-1000 resources


Tasks
=====

0. Dashboard - (ashee)
1. Database Schema (ashee)
2. Data Load (Scripts) (ashee)
3. New Encounter Form (mbleed)
	3.a Type-assist 
4. Resources (alotia)
	4.a Create Resource 
	4.b Vote Resource (mbleed)
	4.c Resource popularity (statistical or whatever methods)
	4.d Resource Delivery (mbleed)
3. List Encounters (laurie)
5. Faculty View (to be designed) (laurie)
6. Director's View (to be designed)	(ashee)
7. Add cosign module (ashee)
8. Functional testing automation (lotia)

Production/Rollout
-------------------
1. Request DNS entry cltp.umms.med.umich.edu (ticket # 38899)

-----

# Dev Tasks
1. Schema design
2. Master/reference data
3. Sample data 
		
# Resource design (many instances of resource meta-data as tagged by user)
Resources
http://www.google.com (R1, usage-count: , score: formula(usage-count, ....))

ResourceInstances 
R1, ashee, prob-34
R1, alotia, prob-14

# Questions
1. Is "My Resources" contextual to the Encounter or to the user?
2. Can they perform and observe at the same time?
3. Edits - do we allow edits? When do we freeze edits?
4. Search Encounters by date range?

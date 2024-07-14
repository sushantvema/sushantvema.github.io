# REGUlated LUnar Storage

[Project 2 Spec](https://su24.cs161.org/proj2/) 

## Overview

We use some cryptographic library functions to design a secure file sharing system. 
- Allow users to log in, store files, and share files with others, while in presence of attackers. 

Implement our design by filling in 8 functions which users of the system can call to perform file operations.

*This project is heavily design-oriented.* The starter code provided is only 8 function signature.s

## Checkpoint: Spec Quiz

On Gradescope. Very important for understanding.

## Checkpoint: Design Document

Including but not limited to:
- What data structures? (Struct definitions)
- How will I organize the data I need to store? 
- What will happen when a user calls a function?
- What cryptographic functions will I be using?
- What inputs will be provided to those functions?

Throughout the spec there are several design questions. One way to organize the design document is to answer each of those design questions, one by one.

The more initial thought goes into the design, the more feedback can be offered before I start coding. 

Limit document to 2 pages of text with 11pt font or greater. There is no minimum length as long as you've given a complete overview of the design.

> [!NOTE]
> Course staff suggests keeping a detailed document for myself, and a summarized document for the purposes of the checkpoint.

Deliverable:
- The above, as well as a diagram about how you're organizing the data you're storing. Not part of the 2-page limit.

## Checkpoint: Design Review

Sign up for a 20-minute design review with a staff member. Present the design and receieve feedback for it. Graded for correctness. Can be remote.

Policies for scheduling time slot:
- Need to have design doc submitted by time of review.
- Bunch of other logistical details.

Grading: Everybody starts with 18/15, early reviews 20/15. Max is 15/15 so there are some buffer points.

## Getting Started Coding

1. [Install Golang](https://go.dev/doc/install) 
2. Complete the online [Golang Tutorial](https://go.dev/tour/welcome/1)
3. Accept the [Project 2 Github Classroom Invite Link](https://github.com/login/oauth/authorize?client_id=Iv1.a84bfcae38835499&redirect_uri=https://classroom.github.com/auth/github/callback&response_type=code&state=17bd346d431f43bbb3ed4dc07d27b7aeab9f175657bdc62f)
  - May receieve an email asking to join the `cs161-students` organization.
4. Enter a team name. 
  - Clone repository
5. In README.md, include student ID's and github repo link.
6. In `client_test` directory, run `go test`
  - Go will automatically retrieve dependencies defined in `go.mode` and run tests defined `client_test.go` as well as `client_unittest.go`.
  - Some tests will fail because you have not yet implemented all of the required functions. 
7. There is a unit test framework in the `client` directory where you can create unit tests.
  - In case you only want to run unit tests instead of client tests as well, rename the file to `client_unit_test.go` and run `go test`. 

If the starter code is buggy, do the following:
1. Run only once:
  - SSH: `git remote add starter git@github.com:cs161-staff/project2-starter-code`
2. Run each time you need to pull updated: `git pull starter main`

## Checkpoint: Testing

Deliverable: Submit implementation in the `client_test.go` file to Project 2 Testing Checkpoint in Gradescope. 

Autograder will run tests against staff implementation of `client.go`. 

> [!NOTE]
> See more about the details of test coverage under the Autograder: Test Coverage heading.

In staff implementation, each flag is one that tests for integrity or not. In order to receive full credit, hit at least one flag that tests for integrity. 

Score for testing checkpoint will be determined by tests you write and nothing more. Possible to get full score on testing checkpoint **without any code in client.go** . 

Write test cases that hit at least 5 flags. Hitting 4 non-integrity flags will garner you 4/5 on testing checlpoint. Need 4 non-integrity and 1 integrity flag or 3 non-integrity and 2 integrity flags. 

Not all the flags are included in the testing checkpoint by design. Want students to write interesting edge cases. 

> [!NOTE]
> Many students find that writing tests prior to coding `client.go` gives a better understanding of the APIs. 

Don't rush into coding until you have determined a test suite and had design review. 

> [!IMPORTANT]
> Remember that one of our security principles is to design security in from the start. 

## Finding Flags

Difficult to write a lot of test cases without knowing what the flags represent. To correspond to a real world environment, course staff won't answer any questions about what flag numbers on Autograder correspond to nor will they give hints as to what flags are. 

To write more robust test cases, go through the Design Questions listed throughout the spec to think through what possible security testing can be performed. 

> [!NOTE]
> The API lists out when a function should succeed and fail - these are great tests to write.

### Test Writing

To write more robust test cases, follow the test writing workflow (testing with Ginkgo in the Suggested Workflow page).

## Autograder: Implementation

**Deliverable:** Submit implementation in `client.go` file to the Project 2 Autograder assignment on Gradescope.

Before deadline, autograder will only check compilation of code. Will run same basic tests that were provided in the starter code. Won't be able to see actual score for project before the deadline. 

After deadline will run all the functionality and security tests on design, releasing final autograder score. 

Almost all tests for project are hidden and not run until after the deadline. 

Encourage you to write your own tests to check the functionality requirements and simulate attacks that we'll be running on the system.

Staff has many years of accumulated knowledge about attacks, while we only have one semester to think about the project. Expected that design will not score full points on the autograder, and this will be accounted for in grading.

Grade distribution for this project looks similar to a typical CS 161 exam curve. Think of this as a long take-home exam.

Each failed test that doesn't work on my system incurs a multiplicative penalty. If every test has a 10% penalty, each failed test multiples total score by 0.9. 

> [!IMPORTANT]
> Code can't use any external libraries beyond the ones that staff has imported.

## Autograder: Test Coverage

**Deliverable:** Submit `client_test.go`, file with tests you've written, to Project 2 Autograder assignment on Gradescope. 

Some basic tests in the starter code, but will need to write majority of tests yourself. 

The staff implementation contains 24 specially-flagged lines of code that correspond to interesting behavior. We check how many flagged lines of code are executed as result of running your tests. 

Each flagged line of code you to run is worth 1 coverage flag point. Tests need to cause 20 of the flagged lines of code to execute. Staff can't answer any questions about what the flag numbers on the autograder correspond to. 

Can check test case coverage by submitting to autograderon Gradescope at any time before project deadline. Coverage score on Gradescope is final score for the projec.

Getting full score on coverage flags doesn't guarantee anything about own implementation. If code-coverage is non-deterministic, can't promise that score will stay the same after re-running the autograder.

## Final Design document

**Deliverable:** Submit updated version of design document to Project 2 Final Design Doc on Gradescope. 

## Suggested Workflow

### Design Workflow

- Read through the entire spec
  - Easy to miss design requirements which can cause trouble later. Internalize all the requirements
- Design each section in order
  - Start with authentication. How to ensure users can log in? Focus on getting `InitUser` and `GetUser` properly designed. Don't worry about file storage or sharing yet. 
  - After you're satisfied with login functionality, move on to file storage function. Make sure that a single user is able to `LoadFile` and `StoreFile` properly. 
  - Move on to `AppendToFile`
  - Now do sharing and revoking. 
- Don't be afraid to redesign. 
  - Normal to change your design as you go. If you follow suggested function order in the spec, then `AppendToFile` might result in changes to `LoadFile` and `StoreFile`. 
  - `RevokeAccess` might result in changed to `CreateInvitation` and `AcceptInvitation`. 
  - Easier to change design while in design phase. 


### Coding Workflow

- Stay organized with helper functions
  - Code in helper functions allows writing unit tests and composability.
- Test as you go
  - Don't write a huge chunk of code and then test at the very end. Write small pieces of code incrementally, and write tests as you go to check code is doing what it needs to.

### Testing with Ginkgo

This section provides basic documentation for Ginkgo, framework for writing test cases. 

Read basic tests in `client_test.go`. First few are well documented in-line. 

#### Basic Usage

Should be able to write most of the tests using some combination of calls to:
1. Initialization methods (e.g `client.InitUser`, `client.GetUser`  )
2. User-specific methods (e.g `alice.StoreFile`, `bob.LoadFile`  )
3. Declarations of expected behavior (e.g `Expect(err).to(BeNil())` )

#### Asserting Expected Behavior

```go
// Check that an error didn't occur
alice, err := client.InitUser("alice", "password")
Expect(err).To(BeNil())

// Check that an error didn't occur
err = alice.StoreFile("alice.txt", []byte("hello world"))
Expect(err).To(BeNil())

// Check that an error didn't occur AND that the data is what we expect
data, err := alice.LoadFile("alice.txt")
Expect(err).To(BeNil())
Expect(data).To(Equal([]byte("hello world")))

// Check that an error DID occur
data, err := alice.LoadFile("rubbish.txt")
Expect(err).ToNot(BeNil())
```

#### Organizing Tests

Can organize tests using some combination of `Describe(...)` containers, with tests contained within `Specify(...)`. 

> [!NOTE]
> Read more about organizing tests here: [Ginkgo](https://onsi.github.io/ginkgo/#organizing-specs-with-container-nodes)
#### Running a Single Test Case
If you would like to run only one single test you can change the `Specify` of that test case to a `FSpecify`. For instance if you have a test:

```go
Specify("Basic Test: Load and Store", func() {...})

// renamed to
FSpecify("Basic Test: Load and Store", func() {...})
```

> [!WARNING]
> Remove all `FSpecify` statements when you submit to the autograder (otherwise, autograder will only run tests labelled `FSpecify` ) or potentially break the autograder. Staff might not re-run tests for you.

#### Optional: Measure Local Test Coverage

To measure and visualize local test coverage (e.g how many lines of implementation test file hits), you can run these commands **in the root folder of your repository**:

```bash
go test -v -coverpkg ./... ./... -coverprofile cover.out 

go tool cover -html=cover.out

```

Coverage over implementation may serve as an indicator for how well code will perform (with regards to coverage flags) when compared to staff implementation. Can help to write better unit testing to catch edge cases. 

## Design Overview
A high level overview of what we'll be designing. 

### Functionality Overview
Designing a system that allows users to securely store and share files in presence of attackers. Implementing following 8 functions:
- `InitUser`: Given new username and password, create a new user
- `GetUser`: Given username and password, let the user log in if the password is correct. 
- `User.StoreFile`: For a logged-in user, given a filename and file contents, create new file or overwrite existing file.
- `User.LoadFile`: For a logged-in user, given a filename, fetch the corresponding file contents. 
- `User.AppendToFile`: For a logged-in user, given a filename and additional file contents, append the additional file contents at the end of existing file contents. Also follows certain efficiency requirements.
- `User.CreateInvitation`: For logged-in user, given a filename and target user, generate an invitiation UUID that target user can use to gain access to the file.
- `User.AcceptInvitation`: For logged-in user, given an invitation UUID, obtain access to file shared by different user. Allow recipient user to access file using a possibly different filename of their own choosing. 
- `User.RevokeAccess`: For a logged-in user, given filename and target user, revoke target user's access to they are no longer able to access a shared file.

More details forthcoming in the spec. No need to implement a frontend for this project. All users will interact with system by running a copy of my code and calling these 8 functions. 

### The User Class
8 functions above are part of the `User` class. This class has:
- Two constructors, `InitUser` and `GetUser`, which create and return new `User` objects. A `User` object is represented as a reference to a `User` struct containing instance variables. This constructor is called every time a user logs in.
- 6 instance methods which can be called on the `User` object. User calls these functions to perform file and sharing operation. 
- Instance variables specific to each `User` object, which can be used to store information about each user. Instance variables are stored in `User` returned by constructor, instance variables are accessible to all of the instance methods. 

If user calls a constructor multiple times, there will be multiple `User` objects that all represent the same user. Need to make sure that these `User`  objects do not use outdated data. 



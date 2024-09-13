---
title: "Prompt Decomposition Article Scraped"
---

(Code examples in this repo, explained near the end of this post!)

What is blocking the adoption of Generative AI at scale?
As a Generative AI Specialist for AWS, I have had the opportunity to work with over 50 customers in the last 18 months. I’ve seen a lot of generative AI proof of concepts (PoC’s), both successes and failures, and I’ve helped many teams who were stuck at the end of the PoC stage. These workloads get blocked for all kinds of reasons and some of the most common blockers are:

Low accuracy. Teams have tried all the prompt engineering best practices and accuracy is still not good enough. It is unclear what else can be done to increase accuracy.
High cost. The estimated cost for running the solution is high and moving to a smaller model lowers the accuracy too much. It is unclear what else can be done to control costs.
Lack of control. The prompt worked OK for a small PoC but as soon as a few users start giving feedback or scope increases, the prompt becomes a nightmare to maintain. A small tweak or addition to the prompt to fix one error may cascade and create three other errors.
High Latency. The system is so slow as to be unusable and moving to a smaller, faster model lowers the accuracy too much. It is unclear what else can be done to decrease latency.
Lack of metrics. There is a gut feel from the team that things are “kinda OK” because they tried a few examples. They have no way to build stakeholder confidence that things will still be good at scale. There are often limited ideas on how to quantitatively measure a non-deterministic free text system to understand and monitor its performance.
The great news is that prompt decomposition can help with every one of these blockers! While there are other techniques that also address some of the above points, and other tools required to scale, prompt decomposition is unique because it is the one piece that I have seen to be most often missing or misunderstood. It has proven to be one of the best tools for addressing these concerns for many of AWS’s largest customers.

That’s a bold claim. Does it really work?
In short — Yes. I have seen this technique unlock scale at some of AWS’s largest customers, and across many different industries. For this blog post, I present the code for two different use cases chosen because they are similar to many of the real projects I have worked on, and their results are typical. For each example I calculate the cost, latency, and accuracy before and after implementing Prompt Decomposition. The first example is focused on increasing accuracy, and the second on reducing latency. Let’s check out the numbers:


Looks pretty good! The first example is focused on increasing accuracy. With best practices in prompt engineering and a single prompt, we only achieve an accuracy of 60%, but with prompt decomposition we are able to bump that all the way up to 100% and shave off nearly half the cost at the same time as a bonus. I have seen this approach get near 100%, and in one case hit 100%, for real use cases. For the second example, we are focused on latency. There, we were able to cut the total response time in half, and bump up the accuracy to boot! A little time spent on prompt decomposition can really pay off.

So what is Prompt Decomposition?
Prompt Decomposition is the process of taking a complicated prompt and breaking it into multiple smaller parts. This is the same idea that is found in design theory and sometimes called task decomposition. Simply put, when we have a large complicated task, we break it down into multiple steps and each step is individually much easier.

We do this intuitively to solve tasks in our daily life and it translates very well to generative AI. Consider finding summer camps for a child to attend. It can be daunting to look at all the options, prices, timing, context, etc. Trying to do it all at once may feel impossible, and you may miss things if you do it without a plan. However, if you do some planning and break it down into simple steps the overall task is much more likely to go well. Let’s take a look at it visually:


A system for recommending summer camps.
Here, we imagine a system that accepts information about a child, including the child’s age, requested camp date, and interests, and then it returns a recommended camp. (We’ll build this later!) This high level diagram may seem simple, but it is a critical part of the design process because it allows us to define scope and get a clear view of the external data sources and users we will be interacting with. Next, let’s decompose this task:


Camp recommendation system, decomposed into 3 steps.
Here, we’ve broken the system into 3 steps:

1.0) Extract information, in this case the child’s age, the date requested for camp, and the dates and age ranges that camps are offered for.

2.0) Find all possible camps by matching the child’s age and date request to camps that accept that age on that date. We don’t want to recommend a camp for a date that it is not offered!

3.0) Based on the list of camps that are available for the child’s age and requested date, recommend a camp based on the child’s interests.

We’ll take a deeper look at this system later, but for now notice that as the task is broken down, it becomes easier to imagine how you would execute each subtask. For example, look at 2.0. It is given age and date information and all it has to do is a math operation to check the child’s age and requested date against the camp requirements. For more complicated systems, you may wish to continue decomposing some steps into additional parts. As a good rule of thumb, keep going until each step is doing roughly a single task.

Another application of prompt decomposition is volume based. In some cases with particularly long prompts, it may be the case that parts of the prompt can be run at the same time even if they are all doing the same task. In one case, we were able to take a prompt that took around 43 seconds to run and break it down into three parts that ran in parallel, and then passed their results to a fourth prompt to combine the results of the first three. As a result, the same task that originally took 43 seconds now takes under 10 seconds in total, and also costs far less because the individual steps used a smaller model with no loss to accuracy.

How does Prompt Decomposition unlock scale?
Now that we know what it is, let’s take a look at each of the blockers listed above and explore how prompt decomposition empowers teams to overcome each one.

Low accuracy. When a prompt is performing only one task, we can focus all our effort on using the best tools to perform that task. That means that for each step, we can pick the right sized model. Further, some steps may not need generative AI at all! If some part of the large prompt was doing math for example, we can simply replace that decomposed step with actual math via programing and avoid using LLM’s for tasks that they are not designed for. Finally, we can cut out all extraneous instructions or examples that are not related to our specific task, and focus instead on instructions and examples useful for that step.
High cost. High cost is often driven by a large prompt being sent to a large model. When a prompt is large it is often complicated, meaning it requires a larger model to achieve high accuracy. When a prompt is broken down into many separate prompts, the appropriate model can be used for each step. This opens the door to using many different models for a single workload. For example, it is very common to start a task with a semantic router — a very small prompt that decides what kind of request has come in. That often only needs a very small model to run, and it may route the request to a different sized model as needed. When the user says “hello” to open a chat, we hardly need to send that to Claude Opus with a dozen tools available in order to generate a response! After decomposition it is very common to see a massive cost drop due to the freedom to use smaller models for some steps, the ability to route entirely around unused steps for some queries, and the freedom to not use LLM’s at all for some steps.
Lack of control. LLM’s are non-deterministic, and this means that with large prompts, a change to one part of the prompt can change how another part acts. This often shows up when a team is working on achieving that last bit of very high accuracy. A prompt may be at 90% accuracy, but the tweaks needed to help one part of the prompt may hinder another, creating a barrier that can be hard to overcome. By breaking tasks into separate prompts, we eliminate this behavior because we can focus on one task at a time and any changes to one will not impact the other prompts. Additionally, consider the case where you have multiple possible tasks for your workload to accomplish. It is common to put a small semantic router in front of these, which takes an incoming task and routes it to the correct prompt. Now, when you want to add a new capability, it’s as simple as adding a new path to the router and none of the existing prompts are impacted.
High Latency. As a general rule, the larger the model, the slower it runs. When you only have one prompt, you only get to pick one model to run it, and the entire thing runs every time. With a series of prompts working together, you can select the best model for each prompt which often results in some, if not all, of the steps running on smaller, faster, models. In addition, it is very common for individual steps of a task to be independent enough that they can be run in parallel, or even be run ahead of time with cached results, which creates significant increases in overall speed. Finally, a good system of prompts may identify some steps that don’t need to be run at all for certain queries, reducing the latency even further.
Lack of metrics. This is perhaps the single most important point in this list. With a single prompt, you only have a single place where you can attach metrics, which only gives you a single view of how the whole system is doing. By breaking the system down into multiple steps, you can measure the accuracy and other metrics at each step in the system. Many times, I have seen this process reveal problems in LLM logic that were impossible to detect in the larger prompt. This allows you to pinpoint, measure, and address problems. In addition, this gives you a much richer set of metrics at scale, and allows your team and any stakeholders to build confidence that the system is working correctly and will continue to do so.
Sounds good? Let’s get building! (Code included)
For the full code referenced here, please see this GitHub repository. The rest of this blog post will merely highlight the most important components of the code, but please follow along in the notebook and try out the code for yourself. All the code was built using Amazon Bedrock, and uses Anthropic’s Claude 3 models.

In the GitHub repo, the Jupyter Notebook Prompt_Decomposition.ipyn contains all the code used in this blog. In that notebook there is code for two different prompt decomposition examples, one task based looking at accuracy and one volume based looking at latency. Both examples lower cost as well. There is also an updated evaluation function originally written about in this blog. The notebook includes multithreaded calls to Bedrock so that a full set of evaluations can be run in parallel in just a few seconds. Once you start doing prompt engineering with 5 second evaluation feedback looks, you’ll never want to look back.

It all starts with evaluation.
Automated evaluation is critically important because it measures the impact of our solution. Without evaluation, all generative AI is just taking shots in the dark and hoping for the best. With that in mind, let’s take a look at the evaluation function first. We start with a gold standard set of input/output pairs. This must be generated by a human, and is the best case standard we set for what the system should be able to do. (Do not make the terrible mistake of using generative AI to create your gold standard set. This has unfailingly lead to heartbreak and tears of frustration.) The best way to build this set is to start by listing out the categories of inputs you expect to see including valid uses, edge cases, and unwelcome input. As a best practice, you should have at least 100 pairs in your gold standard set, and thoroughly cover all categories.

The evaluation function works by using an LLM as a judge and asking the LLM to compare “correct” answers from our golden test set, and “generated” answers from our system. It can be effective to ask the LLM to take on the role of a teacher grading student work. Here is what the prompt looks like:

Evaluation Prompt:

test_prompt_template_system = """You are a detail oriented teacher.  
You are grading an exam, looking at a correct answer and a student 
submitted answer.  Your goal is to score the student answer based 
on how close it is to the correct answer.This is a pass/fail test.  
If the two answers are basically the same, the score should be 100.
Minor things like punctuation, capitilization, or spelling should 
not impact the score.

If the two answers are different, then the score should be 0.
Please you your score in a 'score' XML tag, and any reasoning 
in a 'reason' XML tag.
"""
test_prompt_template = """
Please score this submission.
Here is the correct answer:
<correct_answer>{{GOLD_OUTPUT}}</correct_answer>
Here is the student's answer:
<student_answer>{{OUTPUT}}</student_answer>"""
Note that here we happen to have a task that is pass/fail, but this prompt is more often used to generate a numeric score from 0–100. Consider that you can fine tune this prompt with examples and instructions to give you the metrics most useful for your workload. You might list things that could be wrong, and how many points you would take off for each error. By looking at the LLM’s reasoning for the score we can get advice on how to fine tune our task’s prompts as well as input on how to further refine our judge prompt. Now that we have a method for evaluation, we’re ready to start building our decomposed system of prompts.

Task based decomposition

The first example is a system that is intended to give recommendations for summer camps. A parent can send in their child’s interests, age, and requested date for camp. The system should then check for available camps for that age and date and create a recommendation based on the child’s interests. Ideally we’ll recommend a camp that matches the child’s interest, but it must be available on the requested day, and accept children of the requested age. For this example, we are provided a list of 20 summer camps, and a list of 25 potential queries along with their expected camp in our gold standard set.

The gold standard test cases try to cover every major use case, as well as edge cases. Categories we include are:
— basic use: Age and date range work, and the ask is clearly for a single camp. This is how we expect “normal” usage to look.
— second_pick: The child’s main interest matches a camp that is out of range, but includes a second option that is in range.
— age: child is too old or young for camp, none are available.
— time: The ask is for a time outside of when camps are offered.
— indirect_time: Like basic use, but the desired date is asked for indirectly
— indirect_age: Like basic use, but the desired age is asked for indirectly.

The format is [Case ID, Category, Query, Correct Response]

test_cases = [
   [1,"basic","My 6-year-old daughter loves all things creative and artistic. She's always drawing, painting, or making crafts. We're looking for a summer camp on August 1st that would allow her to explore her artistic talents and express her creativity. Could you recommend a camp that would be a good fit for her interests and age?","Artistic Expressions Camp"],
   [2,"basic","My 6-year-old son is fascinated by the circus and loves to perform silly tricks and jokes. He has a natural flair for entertaining others. We're looking for a camp on June 20th that could nurture his interest in circus arts and allow him to explore his creative side. Could you recommend a suitable camp for him?","Circus Spectacular"],
   [3,"basic","My 7-year-old son is fascinated by magic and fantasy stories. He loves reading about wizards, casting spells, and going on magical adventures. We're looking for a camp on July 22nd that could fuel his imagination and allow him to explore the world of wizardry in a fun and engaging way.","Wizard Academy"],
   [4,"basic","My 8-year-old daughter is a budding artist who loves to express herself through various creative mediums like painting, drawing, and sculpting. We're looking for a summer camp on August 2nd that can nurture her artistic talents and provide her with an opportunity to explore different art forms under the guidance of experienced instructors. Can you recommend a suitable camp for her?","Artistic Expressions Camp"],
   [5,"basic","My 10-year-old daughter is absolutely enchanted by the world of unicorns and all things magical. She loves crafting, exploring nature, and immersing herself in fantastical stories. I'm looking for a camp on June 20th that would cater to her interests and allow her to unleash her imagination in a whimsical setting.","Magical Unicorn Adventure Camp"],
   [6,"second_pick","My 10-year-old son is fascinated by robots and loves to program.  I really need somewhere he can learn about innovating with robots. He also reads about mythical creatures when he’s bored. We're looking for a summer camp on August 9th that could build his ability to innovate. Could you recommend a suitable camp for him?","Mythological Adventures"],
   [7,"second_pick","My 11-year-old daughter is passionate about singing, acting, and dancing. Her dream is to perform in the circus!  She loves clowns so much.  We are looking for a camp during the week of August 11th that would allow her to explore her interests further and potentially participate in a production. Can you recommend a suitable camp for her?","Musical Theatre Extravaganza"],
   [8,"second_pick","My 16-year-old son is interested in attending a summer camp on August 19th. He has a keen interest in extreme sports, he loves soccer and football.  When not having fun with extreem sports, he's always coming up with ideas for new products or services. Could you recommend a camp that would allow him to explore these interests and develop his skills?","Entrepreneurial Sharks"],
   [9,"second_pick","My 17-year-old son is fascinated by technology and has a keen interest in robotics. He once built a whole robot from a box of spare parts while in a cave in the desert!  He'll be available on August 20th, and we're looking for a camp that would allow him to explore his passion for building and programming robots. When the power is out, he also loves making up wth new ideas for how to sell robots.  Could you recommend a suitable camp that aligns with his interests and the desired date?","Entrepreneurial Sharks"],
   [10,"age","My 5-year-old daughter is fascinated by unicorns and all things magical. She has a vivid imagination and loves creating her own stories and adventures. We're looking for a camp on July 4th that caters to her interests and allows her to explore her creativity in a fun and engaging way.","Sorry, we do not have any summer camps that match your request."],
   [11,"age","My 5-year-old daughter is very imaginative and loves anything related to magic and fantasy. We're looking for a camp on August 11th that could spark her creativity and allow her to explore her interests in a fun and engaging way.","Sorry, we do not have any summer camps that match your request."],
   [12,"age","My 18-year-old son is interested in attending a summer camp on June 10th. He has a keen interest in entrepreneurship, business, and pitching ideas to potential investors. Could you recommend a camp that aligns with his interests and age group?","Sorry, we do not have any summer camps that match your request."],
   [13,"age","My 18-year-old son is interested in starting new businesses. He would love to attend a camp on August 14th that aligns with his interests and allows him to explore cutting-edge concepts while also having fun.","Sorry, we do not have any summer camps that match your request."],
   [14,"time","My 10-year-old son is really interested in science and technology. He loves building things and learning about how things work. We're looking for a camp on June 10th that could nurture his curiosity and allow him to explore his interests in a fun and engaging way.","Sorry, we do not have any summer camps that match your request."],
   [15,"time","My 17-year-old son is really interested in starting new businesses. He loves building things and learning about how things work. We're looking for a camp on July 20th that could nurture his curiosity and allow him to explore his interests in a fun and engaging way.","Sorry, we do not have any summer camps that match your request."],
   [16,"time","My 7-year-old son is available on August 12th, and he's absolutely fascinated by anything related to magic, fantasy, and mythical creatures. Could you recommend a camp that aligns with his interests and the available dates?","Sorry, we do not have any summer camps that match your request."],
   [17,"time","My 6-year-old son is really interested in fantasy and magic. He loves stories about wizards, unicorns, and mythical creatures. We're looking for a camp on July 20th that could spark his imagination and allow him to explore these interests in a fun and engaging way.","Sorry, we do not have any summer camps that match your request."],
   [18,"indirect_time","My 6-year-old daughter loves all things creative and artistic. She's always drawing, painting, or making crafts. We're looking for a summer camp two days before August 3st that would allow her to explore her artistic talents and express her creativity. Could you recommend a camp that would be a good fit for her interests and age?","Artistic Expressions Camp"],
   [19,"indirect_time","My 6-year-old son is fascinated by the circus and loves to perform silly tricks and jokes. He has a natural flair for entertaining others. We're looking for a camp a week after June 13th that could nurture his interest in circus arts and allow him to explore his creative side. Could you recommend a suitable camp for him?","Circus Spectacular"],
   [20,"indirect_time","My 7-year-old son is fascinated by magic and fantasy stories. He loves reading about wizards, casting spells, and going on magical adventures. We're looking for a camp a month after June 22nd that could fuel his imagination and allow him to explore the world of wizardry in a fun and engaging way.","Wizard Academy"],
   [21,"indirect_time","My 8-year-old daughter is a budding artist who loves to express herself through various creative mediums like painting, drawing, and sculpting. We're looking for a summer camp the day before August 3rd that can nurture her artistic talents and provide her with an opportunity to explore different art forms under the guidance of experienced instructors. Can you recommend a suitable camp for her?","Artistic Expressions Camp"],
   [22,"indirect_age","My 5-year-old daughter has a birthday May 3rd this year, and loves all things creative and artistic. She's always drawing, painting, or making crafts. We're looking for a summer camp on August 1st that would allow her to explore her artistic talents and express her creativity. Could you recommend a camp that would be a good fit for her interests and age?","Artistic Expressions Camp"],
   [23,"indirect_age","My older son is 7, and my younger is 6.  I need a camp for the younger one, he is fascinated by the circus and loves to perform silly tricks and jokes. He has a natural flair for entertaining others. We're looking for a camp on June 20th that could nurture his interest in circus arts and allow him to explore his creative side. Could you recommend a suitable camp for him?","Circus Spectacular"],
   [24,"indirect_age","My 6-year-old son is going the have a wizard themed birthday tomorow.  He is fascinated by magic and fantasy stories. He loves reading about wizards, casting spells, and going on magical adventures. We're looking for a camp on July 22nd that could fuel his imagination and allow him to explore the world of wizardry in a fun and engaging way.","Wizard Academy"],
   [25,"indirect_age","I have two boys, 5 and 10, and a daughter who is 8.  My daughter is a budding artist who loves to express herself through various creative mediums like painting, drawing, and sculpting. We're looking for a summer camp on August 2nd that can nurture her artistic talents and provide her with an opportunity to explore different art forms under the guidance of experienced instructors. Can you recommend a suitable camp for her?","Artistic Expressions Camp"]
]
First, we try to accomplish this task using a single prompt:

prompt_template_system = """You are a summer camp advisor, in charge of placing kids into summer camps based on their interest.
Here is the list of summer camps that are avalaible this summer:
{{CAMPS}}
It is critical that kids are only placed in camps approved for their age.
It is critical that kids only join camps that are offered on the day they are requesting.
Every camp offers single day drop in any day in its date range.
If no camp can be found for the age and date requested, please say "Sorry, we do not have any summer camps that match your request."
"""
prompt_template_system = prompt_template_system.replace("{{CAMPS}}",camps)
prompt_template = """Here is a request from a parent:
<text>
{{INPUT}}
</text>
Which camp do you recommend?  Put "Sorry, we do not have any summer camps that match your request." or the camp name in 'camp' XML tags, and your reasoning in 'reason' tags.
"""
This prompt produces an accuracy of about 60%, with both Haiku and Sonnet. After examining the LLM’s reasoning on the incorrect ones and trying a few things, prompt engineering does not seem to be able to help. Now let’s try again, this time decomposing the task into three steps.

Step 1: Extract the age and date requirements from the request.

prompt_template_step_1_system = """You are detail oriented data extraction expert.
Your job is to examine a short message which is a request from a parent for summer camp advice, and extract the age of the child and desired date for camp.
First, extract the exact age mentioned in the request, and check to see if a birthday is mentioned.  Write your answer in a 'temp' XML tag, in the format (age,True/False birthday mentioned.)
Only when a birthday is stated, and the birthday is before the requested date of camp, add one to the value in 'temp' and consider that to be the new age.
Age is of critical importance to the process, so you must never assume or guess when a birthday is.  Instead, you must always use the exact age given by the parent, except when a pre-camp birthday is explictly mentioned.
Next, inside an 'answer' XML tag, write the requested age and date as "age,date"
Finally, include your reasoning in 'reason' tags.
The date should be in YYYYMMDD format, and the current year is 2025.
"""
prompt_template_step_1 = """Here is a message for data extraction:
<text>
{{INPUT}}
</text>
"""
Step 2: Match the date and age requested against the camp listings to create a list of possible camps for the request. Not shown here, in the notebook we use a separate prompt to do a one time data extraction task and extract the age and date requirements from the free text list of camps. Because we now have all the data extracted from both the list of camps and the parent’s request, and in numeric rather than free text format, a simple python loop to compare ranges generates a list of the available camps for each query.

#generate the list of camps that work for each request in the gold standard set.
#this object will be passed to our tweaked generate results function.
camps = {}

for test_id,category,i,o in test_cases_3:
    #get the requested age and date for this camp
    age_date = testID2age_date[test_id]
    this_age = int(age_date.split(',')[0])
    this_date = int(age_date.split(',')[1])
    #find the matching camps
    this_camp = []
    for campID in campID2age_date:
        age_date = campID2age_date[campID]
        age_date = age_date.replace("[",'').replace("]",'').split(',')
        low_age = int(age_date[0])
        high_age = int(age_date[1])
        low_date = int(age_date[2])
        high_date = int(age_date[3])
        
        if this_age>=low_age and this_age<=high_age and this_date>=low_date and this_date<=high_date:
            this_camp.append(campID2camp[campID])
    this_camp = "\n".join(this_camp).strip()
    if len(this_camp)<1:
        this_camp = "No camps match this request."
    camps[test_id] = this_camp
Step 3: Create a recommendation based on the child’s interest and possible camps. By using the data from the previous steps we can create a prompt that doesn’t have to worry about age or date and can just focus on interests. On my first run, the accuracy of this step was around 70% and I found some really interesting things in the LLM’s reasoning tags. For example, the LLM had a hard time understanding the difference between a Jedi and a wizard, and would recommend that a child interested in wands go to Jedi camp rather than wizard camp. This assumption was hidden in the original large prompt, but now that this focused step revealed the problem, this issue and others were very easy to correct and pop the accuracy all the way up to 100%.

prompt_template_decomposed_system = """You are a summer camp advisor, in charge of placing kids into summer camps based on their interest.
If no camp can be found for the age and date requested, please say "Sorry, we do not have any summer camps that match your request."
You will be given a list of summer camps that a director has already approved as possible options based on age and date.
You may safely ignore any age and date information, and instead focus on reccomending the camp that is best aligned with the child's interest.
"""
prompt_template_decomposed = """
Here is the list of summer camps that are avalaible for this request:
<camps>
{{CAMPS}}
</camps>
Here is a request from a parent:
<text>
{{INPUT}}
</text>
Which camp do you recommend?  Put "Sorry, we do not have any summer camps that match your request." or the camp name in 'camp' XML tags, and your reasoning in 'reason' tags.
"""
Running this system of three steps gave us perfect accuracy, although to really trust that number we would need at least 100 test cases rather than the 25 we have now. Over all we have much better control over the accuracy, and can decide which models to use when. Now let’s take a look at the second use case.

Volume based decomposition

Twice as fast when broken down into 4 calls.
For this use case, we consider a task that involves a very long prompt. Again I only look at code highlights here, for the complete code visit this GitHub repo and skip down to the second half of the notebook. Here we want to read the entire Frankenstein novel and count how many characters there are as well as generate a quick description of the top three most comon characters. This can be done in a single long prompt, but it’s also a great task to break down because counting characters is not dependent on doing it in order. You should get the same count whether you read the book front to back, or if you read each chapter in a random order. Here is the prompt that we use to read the whole novel in a single prompt:

long_prompt_template = """Consider the following novel:
<novel>
{{NOVEL}}
</novel>

How many unique characters are there with at least one spoken line of dialog?  Please also provide a brief description of only the top three most common characters, each in separate paragraphs. 
Only count charaters that have at least one spoken line of dialog.
"""
Running that takes about 40 seconds. Now let’s break it into three parts, and run each part at the same time. A bit of testing found 3 to be a sweet spot, breaking it down further gave diminishing returns. Here’s the prompt for a singlesmaller part, which we feed a third of the novel to:

short_prompt_template = """Consider the following portion of a novel:
<novel>
{{NOVEL}}
</novel>

Please provide a list of unique characters, each in a character tag.  Inside the character tag should be a name tag with their name,
a count tag with an exact count of times they appear, and a description tag with a brief description of that character.
Only count charaters that have at least one spoken line of dialog.
"""
And one more prompt to generate a single result after the three parallel parts are done:

final_prompt_template = """Consider the following list of charaters from a novel.  Each entry contains the character's name,
a count of the number of times they appeared, and a brief description of that charater:
<characters>
{{CHARACTERS}}
</characters>
Some charaters may be listed more than once.  Use the name and description to determine that two entries are the same, 
and if they are, sum their count to support your responce.

How many unique characters are there?  Please also provide a brief description of the top three most common characters in separate paragraphs. 
"""
By decomposing the task this way, we get results twice as fast! It also slightly boosted the accuracy. This is a surprisingly common side effect when switching to multiple calls because each call has a smaller prompt and can focus more of its reasoning power on the task at hand. Smaller, faster, more accurate, about the same cost — what’s not to love?

Now go forth and decompose!
Many different elements are required to support generative AI at scale, but more than any other Prompt Decomposition has been the missing link. Again and again I have seen it give teams the boost they need to push into production. I hope this post and code can do the same for you. If you are looking for a good place to start with your own workload, I recommend creating a flow chart for your task, and then considering what tool, gen AI or otherwise, will be best to enable each step. Feel free to comment with questions, or share your own challenges and successes. Let’s go build something amazing by taking it apart!


Disclaimer
I am a Generative AI Specialist SA working for AWS. While the suggestions in this post are drawn from my experience working with many different AWS customers, all opinions are my own and should not be attributed to AWS.

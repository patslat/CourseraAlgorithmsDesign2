require 'rspec'
require_relative '../lib/greedy_scheduling'

describe "process_jobs" do
  it "returns jobs and number of jobs" do
    number_of_jobs, jobs  = process_jobs("lib/jobs.txt")

    jobs.length.should == number_of_jobs
  end
end

describe "sort_by_greedy_difference" do
  it "sorts in descending order by the work - length difference" do
    jobs = [[1, 2], [3, 9], [5, 5]]
    sort_by_greedy_difference(jobs).should == [[5, 5], [1, 2], [3, 9]]
  end

  it "uses largest work if there is a tie in difference" do
    jobs = [[2, 8], [1, 7], [3, 9]]
    sort_by_greedy_difference(jobs).should == [[3, 9], [2, 8], [1, 7]]
  end
end

describe "sort_by_greedy_ratio" do
  it "sorts in descending order by the work / length ratio" do
    jobs = [[1, 1], [2, 1], [3, 1]]
    sort_by_greedy_ratio(jobs).should == [[3, 1], [2, 1], [1, 1]]
  end
end

describe "job_sum" do
  it "calculates the weighted sum of completion times" do
    jobs = [[3, 1], [2, 2], [1, 3]]
    job_sum(jobs).should == 15
  end
end

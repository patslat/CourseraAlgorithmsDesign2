# Programming Assignment 1
## Question 1

def process_jobs(jobs_filename)
  jobs = File.read(jobs_filename)
    .split("\n")
    .map { |pair| pair.split(" ").map(&:to_i) }

  number_of_jobs = jobs.delete_at(0)

  return number_of_jobs.last, jobs
end

def sort_by_greedy_difference(jobs)
  jobs_clone = jobs.clone
  jobs_clone.sort! do |job1, job2|
    job_1_weight, job_1_length = job1
    job_2_weight, job_2_length = job2

    job_1_difference = job_1_weight - job_1_length
    job_2_difference = job_2_weight - job_2_length

    if job_1_difference == job_2_difference
      job_2_weight <=> job_1_weight
    else
      job_1_difference >= job_2_difference ? -1 : 1
    end
  end
  jobs_clone
end

def sort_by_greedy_ratio(jobs)
  # this is wrong right now
  jobs_clone = jobs.clone
  jobs_clone.sort! do |job1, job2|
    job_1_weight, job_1_length = job1
    job_2_weight, job_2_length = job2

    job_1_ratio = job_1_weight.to_f / job_1_length.to_f
    job_2_ratio = job_2_weight.to_f / job_2_length.to_f

    job_2_ratio <=> job_1_ratio
  end
  jobs_clone
end

def job_sum(jobs)
  time = 0
  sum = 0
  jobs.each do |job|
    weight, length = job
    time += length
    sum += (time * weight)
  end
  return sum
end

number_of_jobs, jobs = process_jobs("lib/jobs.txt")
p "Job sum using greedy difference: "
p job_sum(sort_by_greedy_difference(jobs))

p "Job sum using greedy ratio: "
p job_sum(sort_by_greedy_ratio(jobs))

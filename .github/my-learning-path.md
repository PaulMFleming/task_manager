# Shogun Learning Path - Progressive Projects for Junior Engineers

## Overview
This document outlines a structured learning path with progressive projects designed to help junior engineers master the complex patterns and skills needed to work efficiently in the Shogun codebase - a sophisticated cloud infrastructure management platform with AWS integrations, background job processing, state machines, and administrative dashboards.

## 🎯 Level 1: Foundation Projects (Start Here)

### Project 1: Personal Task Manager with State Machine
**Skills Learned:** State machines, basic Ruby patterns, database modeling

**Description:**
- Build a simple task tracker where tasks transition through states: `pending` → `in_progress` → `completed` → `archived`
- Use a state machine gem (like `state_machines` used in Shogun)
- Practice the state transition patterns seen in `AwsSnapshot`, `CredentialStore`, etc.

**Key Implementation:**
```ruby
class Task
  include StateMachines::MachineMethods
  
  state_machine :state, initial: :pending do
    event :start do
      transition pending: :in_progress
    end
    
    event :complete do
      transition in_progress: :completed
    end
    
    event :archive do
      transition completed: :archived
    end
  end
end
```

### Project 2: File Upload Monitor
**Skills Learned:** Background jobs, polling, basic AWS S3 (or S3-compatible storage)

**Description:**
- Create an app that monitors file uploads to S3 (or MinIO locally)
- Use background jobs (Sidekiq/Resque) to periodically check upload status
- Practice the polling patterns seen in Shogun's worker tasks

## 🚀 Level 2: Infrastructure Basics

### Project 3: Server Health Dashboard
**Skills Learned:** Monitoring, dashboards, basic cloud resources

**Description:**
- Build a dashboard that monitors your personal servers/VPS instances (or Docker containers)
- Track CPU, memory, disk usage over time
- Create alerts when thresholds are exceeded
- Practice the dashboard patterns from `ControlPlaneDashboard`

### Project 4: Cost Tracker for Personal Infrastructure
**Skills Learned:** Cost management, tagging, resource attribution

**Description:**
- Build a tool that tracks your infrastructure spending (real or simulated)
- Automatically tag resources with cost allocation tags
- Generate cost reports by service/project
- Mirrors the snapshot cost tagging work in Shogun

## ⚡ Level 3: Advanced Patterns

### Project 5: Multi-Service Orchestrator
**Skills Learned:** Complex state machines, task dependencies, error handling

**Description:**
- Create a system that provisions a complete web app stack (database, app server, load balancer)
- Each component has its own state machine
- Handle rollback scenarios when provisioning fails
- Practice the complex orchestration patterns from Shogun's provisioning tasks

### Project 6: Resource Lifecycle Manager
**Skills Learned:** Cleanup automation, orphan detection, cascading operations

**Description:**
- Build a system that automatically cleans up unused cloud resources
- Detect "orphaned" resources (like the EIP/snapshot cleanup patterns in Shogun)
- Implement cascading cleanup (when you delete A, also clean up related B and C)

## 🏗️ Level 4: Production-Ready Systems

### Project 7: Multi-Tenant SaaS Infrastructure
**Skills Learned:** Tenant isolation, resource provisioning, admin interfaces

**Description:**
- Build a mini-SaaS that provisions isolated environments for each customer
- Each tenant gets their own database, S3 bucket, etc.
- Admin dashboard to manage tenant resources
- Practice the multi-tenancy patterns from Shogun's timeline/cluster management

### Project 8: Infrastructure as Code Platform
**Skills Learned:** Complex workflows, rollout management, error recovery

**Description:**
- Create a platform where users can define infrastructure in YAML/JSON
- System provisions resources based on these definitions
- Support rollouts, rollbacks, and progressive deployments
- This is essentially a mini version of what Shogun does!

## 💰 Cost-Free Development Options

### Option 1: LocalStack (Recommended)
**LocalStack** provides a fully functional local AWS cloud stack:

```bash
# Install with Docker
docker run -d -p 4566:4566 localstack/localstack

# Your AWS SDK code works unchanged!
s3_client = Aws::S3::Client.new(
  endpoint: 'http://localhost:4566',
  region: 'us-east-1'
)
```

**Benefits:**
- Free tier covers most AWS services (S3, EC2, Lambda, etc.)
- Real AWS SDK calls work unchanged
- Perfect for learning AWS patterns without costs
- Used by many companies for development/testing

### Option 2: Mock Everything
Create fake implementations that behave like AWS:

```ruby
class MockS3Client
  def initialize
    @buckets = {}
    @objects = {}
  end
  
  def create_bucket(bucket:)
    @buckets[bucket] = { created_at: Time.now }
  end
  
  def put_object(bucket:, key:, body:)
    @objects["#{bucket}/#{key}"] = {
      body: body,
      size: body.length,
      last_modified: Time.now
    }
  end
end
```

### Option 3: Docker-Based "Cloud" Services
Simulate cloud infrastructure with Docker containers:

```yaml
# docker-compose.yml
version: '3.8'
services:
  postgres:    # "Database as a Service"
    image: postgres:15
    ports: ["5432:5432"]
  
  minio:       # "Object Storage Service"  
    image: minio/minio
    ports: ["9000:9000", "9001:9001"]
  
  redis:       # "Message Queue Service"
    image: redis:7
    ports: ["6379:6379"]
```

## 🎓 Key Learning Focus Areas

Based on the Shogun codebase patterns, prioritize learning:

1. **State Machines** - Critical for resource lifecycle management
2. **Background Job Processing** - Essential for long-running operations
3. **AWS SDK Usage** - Core to cloud infrastructure work (even if mocked)
4. **Error Handling & Retries** - Crucial for reliable systems
5. **Database Design** - Proper modeling of complex relationships
6. **Testing Patterns** - RSpec, fabricators, mocking external services
7. **Admin Interfaces** - Building tools for operators

## 🛠️ Recommended Technology Stack

Mirror Shogun's stack for maximum learning transfer:

```ruby
# Gemfile for learning projects
gem 'sequel'           # Database ORM (same as Shogun)
gem 'state_machines'   # State management (same as Shogun)  
gem 'sidekiq'         # Background jobs
gem 'sinatra'         # Web framework (or Rails)
gem 'rspec'           # Testing (same as Shogun)
gem 'fabrication'     # Test factories (same as Shogun)

# For AWS simulation
gem 'aws-sdk-s3'      # Use real SDK with LocalStack
gem 'docker-api'      # Control Docker containers
```

## 💡 Pro Tips for Each Project

- **Start with tests** - Follow the TDD patterns seen in Shogun's specs
- **Use Fabricators** - Practice the factory pattern for test data
- **Mock external APIs** - Learn to test without hitting real services
- **Add proper logging** - Include structured logging like Shogun does
- **Handle edge cases** - What happens when services are down? Network timeouts?
- **Build incrementally** - Each project should take 1-3 weeks

## 🚀 Getting Started

1. **Choose your approach** - LocalStack, mocks, or Docker services
2. **Start with Project 1** - Build it completely before moving on
3. **Focus on patterns** - The architectural concepts matter more than the actual cloud provider
4. **Test everything** - Practice the same testing discipline as Shogun
5. **Document your learning** - Keep notes on patterns you discover

## 📚 Key Shogun Patterns to Practice

### State Machine Pattern
```ruby
class FakeServer
  include StateMachines::MachineMethods
  
  state_machine :state, initial: :pending do
    event :provision do
      transition pending: :provisioning
    end
    
    event :complete do
      transition provisioning: :running
    end
  end
end
```

### Background Job Pattern
```ruby
class ProvisionServerJob
  def perform(server_id)
    server = FakeServer.find(server_id)
    server.provision!
    
    # Simulate provisioning work
    sleep(5)
    
    server.complete!
  end
end
```

### Admin Dashboard Pattern
```ruby
class ControlPanelDashboard
  def rollout_actions
    actions = []
    
    if can_start_cleanup?
      actions << {
        name: "Cleanup Unused Resources",
        description: "Remove orphaned containers",
        action: -> { CleanupJob.perform_later }
      }
    end
    
    actions
  end
end
```

## 🎯 Success Metrics

By completing this learning path, you should be able to:

- ✅ Design and implement complex state machines
- ✅ Build reliable background job processing systems
- ✅ Create administrative dashboards for operations
- ✅ Handle resource lifecycle management
- ✅ Implement proper error handling and retries
- ✅ Write comprehensive test suites with proper mocking
- ✅ Understand cloud infrastructure patterns
- ✅ Debug and troubleshoot complex distributed systems

## 📝 Next Steps

1. Set up your development environment (LocalStack or Docker)
2. Create a new Ruby project for Project 1
3. Set up the basic gems (Sequel, state_machines, RSpec, etc.)
4. Start building your task manager with state transitions
5. Write tests first, following Shogun's patterns
6. Document what you learn and move to the next project

Remember: **The goal is to understand the architectural patterns, not to become an AWS expert**. These projects will teach you the same concepts whether you're managing real cloud resources or simulated ones!

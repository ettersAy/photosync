# Work Process
## Main documentation

**Understand this app**: `doc/Main_documentation.md`

## Assessment
**First, evaluate task complexity:**
- **Simple**: Single file change or small changes in multiple file, minor tweaks, UI adjustments, and with low impact
- **Complex**: Multiple files, new features, architectural changes

## Simple Task Process
1. **Update status**: `1.Instruction_ready.md` → `1.Instruction_in_progress.md`
2. **Implement changes** directly
3. **Update status**: `1.Instruction_in_progress.md` → `1.Instruction_done.md`
4. **Optional**: Brief note in `5.Realisation_Report.md` if needed

## Complex Task Process (Full Workflow)

### File Structure
All files in: `doc/User_Story/[USER_STORY_ID]_[USER_STORY_TITLE]/`

**Core files:**
- `1.Instruction_[status].md` - Main instruction file with current status
- `2.Plan_Report.md` - Technical implementation plan
- `3.Incident_Report.md` - Error and issue documentation
- `4.Test_Report.md` - Testing results and validation
- `5.Realisation_Report.md` - Implementation summary

### Complex Task Phases

#### Phase 1: Initiation
1. **Start** by updating status: `1.Instruction_ready.md` → `1.Instruction_in_progress.md`

#### Phase 2: Planning & Approval
2. **Generate Plan Report** in `2.Plan_Report.md`
3. **Await user review** of the plan
4. **If revision needed**: Update plan and repeat
5. **If rejected**: Update status to `1.Instruction_cancelled.md`
6. **If approved**: Proceed to implementation

#### Phase 3: Implementation
7. **Execute approved plan**
8. **If errors occur**: Update `3.Incident_Report.md`

#### Phase 4: Testing & Validation
9. **Update status** to testing: `1.Instruction_in_progress.md` → `1.Instruction_testing.md`
10. **Generate Test Report** in `4.Test_Report.md`
11. **Generate Realization Report** in `5.Realisation_Report.md`

#### Phase 5: Finalization
12. **If testing fails**: Return to implementation phase
13. **If user requests changes**: Implement and update reports
14. **If successful**: Update main documentation and set status to `1.Instruction_done.md`

## Guidelines
- **Simple tasks**: 2-4 steps, minimal documentation
- **Complex tasks**: Full workflow with all reports
- All reports: Maximum 15 lines, bullet points
- Focus on specific files and code changes
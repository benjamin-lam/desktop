---
# Sprint 2

metadata:
  sprint: 2
  goal: "Batch-Processing & Undo"
  dependencies: ["sprint-1"]
  estimated_duration: "2h"

## Tasks

1. **Batch Mode Implementation**  
   - [ ] Design batch processing module  
   - [ ] Implement functions for batch tasks  
   - [ ] Write unit tests for batch processing  

2. **Undo Functionality**  
   - [ ] Create `history.json` to store actions  
   - [ ] Implement undo feature  
   - [ ] Write tests for undo functionality  

3. **Interactive Progress Display**  
   - [ ] Create user feedback loop during batch processing  
   - [ ] Implement CLI progress indicator  

4. **Error Summary**  
   - [ ] Capture errors during batch processing  
   - [ ] Summarize errors for user display  

## Code Examples

### Batch Processing Example
```python
# Example function for batch processing

def batch_process(items):
    results = []
    for item in items:
        result = process_item(item)
        results.append(result)
    return results
```

### Undo Function Example
```python
import json

class UndoManager:
    def __init__(self):
        self.history = []
    
    def record_action(self, action):
        self.history.append(action)
        with open('history.json', 'w') as f:
            json.dump(self.history, f)

    def undo(self):
        if self.history:
            return self.history.pop()
```

### Interactive Progress Example
```python
import tqdm

def batch_process_with_progress(items):
    for item in tqdm.tqdm(items, desc="Processing items"):
        process_item(item)
```

### Error Summary Example
```python
def handle_error(error):
    print(f"Error: {error}")
```

## Inline pytest Tests
```python
import pytest

@pytest.mark.parametrize("item, expected", [
    (item1, expected_result1),
    (item2, expected_result2)
])
def test_batch_process(item, expected):
    assert batch_process([item]) == expected
```

## Retrospective Template
- **What went well?**
- **What could be improved?**
- **What will we try next time?**

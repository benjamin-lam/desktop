---
YAML Metadata:
  sprint: 3
  goal: "Performance & Caching"
  dependencies: ["sprint-1"]
  estimated_duration: "2h"
  critical: false

# Sprint 3: Performance & Caching

## Tasks

### 1. Embedding Cache with Pickle

```python
import pickle

# Save an object to a file
obj = {'key': 'value'}
with open('example.pkl', 'wb') as f:
    pickle.dump(obj, f)

# Load the object from the file
with open('example.pkl', 'rb') as f:
    loaded_obj = pickle.load(f)
print(loaded_obj)
```

### 2. ChromaDB Query Optimization

```python
# Assume db is an instance of your ChromaDB connector 
# Optimize a query
results = db.query("SELECT * FROM my_table WHERE condition").limit(10)
for result in results:
    print(result)
```

### 3. Asynchronous File Processing with asyncio

```python
import asyncio

async def read_file(file):
    with open(file, 'r') as f:
        data = f.read()
    return data

async def main():
    files = ['file1.txt', 'file2.txt']
    await asyncio.gather(*(read_file(file) for file in files))

asyncio.run(main())
```

### 4. Performance Monitoring with @timeit decorator

```python
import time
from functools import wraps

def timeit(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        print(f'{func.__name__} executed in {end_time - start_time} seconds')
        return result
    return wrapper

@timeit
def example_function():
    sum(range(100000))

example_function()
```

### Inline pytest Tests

```python
def test_example_function():
    assert example_function() is None
```

## Retrospective Template

### What went well:

### What could be improved:

### Action items:

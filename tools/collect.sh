#!/bin/bash
# OSHEF Data Collection Script v1.0
# Usage: Run from the root of a cloned repository
# Output: Prints structured data for OSHEF evaluation

set -euo pipefail

echo "======================================"
echo "  OSHEF Data Collection"
echo "======================================"
echo ""

# ── 1. Code Scale ──
echo "=== 1. Code Scale ==="
echo "--- File count and line count by extension ---"
for ext in py ts tsx js jsx go rs java css; do
  count=$(find . -type f -name "*.${ext}" ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' ! -path '*/build/*' 2>/dev/null | wc -l | tr -d ' ')
  if [ "$count" -gt 0 ]; then
    lines=$(find . -type f -name "*.${ext}" ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' ! -path '*/build/*' -exec cat {} + 2>/dev/null | wc -l | tr -d ' ')
    echo "  .${ext}: ${count} files, ${lines} lines"
  fi
done

echo ""
echo "--- Largest files (top 15) ---"
find . -type f \( -name '*.py' -o -name '*.ts' -o -name '*.tsx' -o -name '*.go' -o -name '*.rs' -o -name '*.java' -o -name '*.js' -o -name '*.jsx' \) \
  ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' \
  -exec wc -l {} + 2>/dev/null | sort -rn | head -16

echo ""

# ── 2. Git History ──
echo "=== 2. Git History ==="
echo "--- Commit count ---"
git log --oneline 2>/dev/null | wc -l | tr -d ' '

echo ""
echo "--- Contributor distribution ---"
git shortlog -sn --all 2>/dev/null | head -15

echo ""
echo "--- Commit date range ---"
echo "First: $(git log --reverse --format='%ai' 2>/dev/null | head -1)"
echo "Last:  $(git log --format='%ai' 2>/dev/null | head -1)"

echo ""
echo "--- Daily commit distribution ---"
git log --format='%ai' 2>/dev/null | awk '{print $1}' | sort | uniq -c | sort -rn | head -10

echo ""
echo "--- Tags ---"
git tag -l 2>/dev/null || echo "(none)"

echo ""

# ── 3. Engineering Maturity ──
echo "=== 3. Engineering Maturity ==="
echo "--- Test files ---"
test_count=$(find . -type f \( -name 'test_*' -o -name '*_test.py' -o -name '*.test.*' -o -name '*.spec.*' \) ! -path '*/node_modules/*' ! -path '*/.git/*' 2>/dev/null | wc -l | tr -d ' ')
echo "Test files found: ${test_count}"
if [ "$test_count" -gt 0 ]; then
  find . -type f \( -name 'test_*' -o -name '*_test.py' -o -name '*.test.*' -o -name '*.spec.*' \) ! -path '*/node_modules/*' ! -path '*/.git/*' 2>/dev/null | head -10
fi

echo ""
echo "--- CI/CD ---"
ci_files=$(find . -path '*/.github/workflows/*' -o -name '.gitlab-ci.yml' -o -name 'Jenkinsfile' -o -path '*/.circleci/*' 2>/dev/null | head -5)
if [ -n "$ci_files" ]; then
  echo "$ci_files"
else
  echo "(none found)"
fi

echo ""
echo "--- Security files ---"
ls SECURITY* .snyk* 2>/dev/null || echo "(none found)"

echo ""

# ── 4. Dependencies ──
echo "=== 4. Dependencies ==="
if [ -f "pyproject.toml" ]; then
  echo "--- Python dependencies (pyproject.toml) ---"
  grep -E '^\s+"' pyproject.toml 2>/dev/null | head -30
elif [ -f "requirements.txt" ]; then
  echo "--- Python dependencies (requirements.txt) ---"
  wc -l requirements.txt | tr -d ' '
fi

if [ -f "package.json" ]; then
  echo ""
  echo "--- Node.js dependencies ---"
  python3 -c "import json; d=json.load(open('package.json')); print(f'dependencies: {len(d.get(\"dependencies\",{}))}'); print(f'devDependencies: {len(d.get(\"devDependencies\",{}))}')" 2>/dev/null || echo "(could not parse)"
fi

echo ""

# ── 5. Import Coupling (Python) ──
py_count=$(find . -type f -name '*.py' ! -path '*/.git/*' 2>/dev/null | wc -l | tr -d ' ')
if [ "$py_count" -gt 0 ]; then
  echo "=== 5. Import Coupling (Python) ==="
  # Detect the main package name
  pkg=$(find . -maxdepth 2 -name '__init__.py' ! -path '*/.git/*' -exec dirname {} \; 2>/dev/null | head -1 | xargs basename 2>/dev/null)
  if [ -n "$pkg" ]; then
    echo "--- Top imported modules from '${pkg}' ---"
    grep -rh "^from ${pkg}\." . --include='*.py' 2>/dev/null | sed 's/import.*//' | sort | uniq -c | sort -rn | head -20
  fi
fi

echo ""
echo "======================================"
echo "  Collection complete."
echo "  Use these results with the OSHEF"
echo "  scoring anchors to evaluate the project."
echo "======================================"

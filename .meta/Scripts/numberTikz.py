import re
import os

counter = 1

def insert_tikzsetnextfilename(file_path):
    global counter

    # Read the LaTeX file
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Regular expression to find the \begin{center} ... \begin{tikzpicture} pattern
    pattern = r'\\begin{center}([\s\S]*?)\\begin{tikzpicture}'
    
    # Function to replace each match with \tikzsetnextfilename{COUNTER} between them
    def replacer(match, counter):
        return f"\\begin{{center}}\\tikzsetnextfilename{{{counter}}}{match.group(1)}\\begin{{tikzpicture}}"
    
    # Find all matches of the pattern
    matches = list(re.finditer(pattern, content))
    
    # Loop over each match and insert the \tikzsetnextfilename
    offset = 0  # This offset will track how much the string length has increased
    for match in matches:
        # Calculate the position at which to insert
        start = match.start(1) + offset
        
        # Insert the \tikzsetnextfilename command after \begin{center}
        content = content[:start] + f"\\tikzsetnextfilename{{{counter}}}" + content[start:]
        
        # Update the offset
        offset += len(f"\\tikzsetnextfilename{{{counter}}}")
        
        # Increment the counter for the next insertion
        counter += 1
    
    # Save the modified content back to the file
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(content)

    print(f"Processed {file_path}")

def process_latex_files(directory):
    # Iterate through all LaTeX files in the given directory
    for filename in os.listdir(directory):
        if filename.endswith('.tex'):  # Process only .tex files
            file_path = os.path.join(directory, filename)
            insert_tikzsetnextfilename(file_path)

# Specify the directory where your LaTeX files are located
#latex_directory = 'path/to/your/latex/files'

# Process all LaTeX files in the specified directory
#process_latex_files(latex_directory)

insert_tikzsetnextfilename("C:\\Users\\Eytan Chong\\OneDrive\\Documents\\DoubleMath\\tex\\Group A\\Chapter A1\\Tutorial A1 copy.tex")
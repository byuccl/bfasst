import sys, os, shutil

import bfasst

def error(*msg):
    print("!!!! ERROR:", " ".join(str(item) for item in msg))
    assert False
    sys.exit(-1)

def create_build_dir(dir):
    new_dir = os.path.join(dir, bfasst.config.BUILD_DIR) 
    if not os.path.isdir(new_dir):
        os.mkdir(new_dir)
    return new_dir

def create_build_design_dir(build_dir, design_dir):
    design_build_dir = os.path.join(build_dir, design_dir)
    if not os.path.isdir(design_build_dir):
        os.makedirs(design_build_dir)
    return design_build_dir

def get_design_dir(design_name):
    return os.path.join(bfasst.EXAMPLES_PATH, design_name)


def clean_folder(folder_path):
    for file_object in os.listdir(folder_path):
        file_object_path = os.path.join(folder_path, file_object)
        if os.path.isfile(file_object_path):
            os.unlink(file_object_path)
        else:
            shutil.rmtree(file_object_path)
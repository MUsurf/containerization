import cv2

# Open a connection to the camera (0 is usually the default camera)
cap = cv2.VideoCapture(0)

# Check if the camera opened successfully
if not cap.isOpened():
    print("Error: Could not open camera.")
    exit()

# Loop to continuously capture frames from the camera
while True:
    # Capture frame-by-frame
    ret, frame = cap.read()

    # If frame is read correctly, ret is True
    if not ret:
        print("Error: Failed to capture image.")
        break

    # Display the resulting frame in a window
    cv2.imshow('USB Camera Feed', frame)

    # Wait for 1 ms and check if the user pressed the 'q' key to exit
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the camera and close all OpenCV windows
cap.release()
cv2.destroyAllWindows()


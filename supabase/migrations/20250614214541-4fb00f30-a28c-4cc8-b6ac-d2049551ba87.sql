
-- Create storage bucket for business videos
INSERT INTO storage.buckets (id, name, public)
VALUES ('videos', 'videos', true);

-- Create RLS policies for video storage
CREATE POLICY "Anyone can view videos" ON storage.objects
FOR SELECT USING (bucket_id = 'videos');

CREATE POLICY "Authenticated users can upload videos" ON storage.objects
FOR INSERT WITH CHECK (bucket_id = 'videos' AND auth.role() = 'authenticated');

CREATE POLICY "Users can update their own videos" ON storage.objects
FOR UPDATE USING (bucket_id = 'videos' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "Users can delete their own videos" ON storage.objects
FOR DELETE USING (bucket_id = 'videos' AND auth.uid()::text = (storage.foldername(name))[1]);
